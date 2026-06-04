#!/usr/bin/env bash
set -e

# Configuración
DATA_DIR="/var/local/vaultwarden/backup"
BACKUP_TEMP="/tmp/vaultwarden_backup"
REMOTE="nit:Backups/Vaultwarden"
DATE=$(date +%Y-%m-%d_%H%M)
FILENAME="vault_$DATE.tar.gz.gpg"
RCLONE_CONFIG="/home/nit/.config/rclone/rclone.conf"

# Función para notificar errores
error_handler() {
    local line_no=$1
   notify-send -u critical -t 0 -a "Vaultwarden Backup" \
        "❌ Error en el Respaldo" \
        "Algo salió mal en la línea $line_no. Revisa los logs, reina."
}

# Trap para capturar errores (excluyendo salidas normales)
trap 'error_handler $LINENO' ERR

echo "Iniciando backup a Google Drive..."

# Limpieza previa y creación de directorio
rm -rf "$BACKUP_TEMP"
mkdir -p "$BACKUP_TEMP"

# Backup de la base de datos (Online Backup)
sqlite3 "$DATA_DIR/db.sqlite3" ".backup '$BACKUP_TEMP/db.sqlite3'"

# Copia de archivos esenciales
cp "$DATA_DIR/rsa_key.pem" "$BACKUP_TEMP/"
[ -d "$DATA_DIR/attachments" ] && cp -r "$DATA_DIR/attachments" "$BACKUP_TEMP/"
[ -f "$DATA_DIR/config.json" ] && cp "$DATA_DIR/config.json" "$BACKUP_TEMP/"

# Cifrado y compresión
tar -cz -C "$BACKUP_TEMP" . | gpg --batch --yes --passphrase "$BACKUP_PASSPHRASE" \
    --symmetric --cipher-algo AES256 -o "$BACKUP_TEMP/$FILENAME"

# Subida a la nube
rclone --config="$RCLONE_CONFIG" copy "$BACKUP_TEMP/$FILENAME" "$REMOTE"

# Sistema de Rotación
echo "Depurando archivos antiguos..."
rclone --config="$RCLONE_CONFIG" lsl "$REMOTE" | \
    sort -k2,3 | \
    head -n -3 | \
    awk '{print $NF}' | \
    while read -r old_file; do
        if [ -n "$old_file" ]; then
            echo "Eliminando backup antiguo: $old_file"
            rclone --config="$RCLONE_CONFIG" delete "$REMOTE/$old_file"
        fi
    done

# Limpieza final
rm -rf "$BACKUP_TEMP"

# Notificación de éxito
notify-send -u normal -t -a "Vaultwarden Backup" \
    "✨ Respaldo Exitoso" \
    "Tu base de datos está a salvo en la nube."

echo "Respaldo terminado con éxito."
