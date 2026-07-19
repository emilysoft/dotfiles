#!/usr/bin/env bash
set -e

# Configuración
DATA_DIR="/var/local/vaultwarden/backup"
BACKUP_TEMP="/tmp/vaultwarden_backup"
REMOTE="nit:Backups/Vaultwarden"
DATE=$(date +%Y-%m-%d_%H%M)
FILENAME="vault_$DATE.tar.gz"
RCLONE_CONFIG="/home/nit/.config/rclone/rclone.conf"

error_handler() {
    local line_no=$1
    echo "❌ [ERROR] Algo salió mal en la línea $line_no. Revisa journalctl -u vaultwarden-backup." >&2
}

trap 'error_handler $LINENO' ERR

echo "Iniciando empaquetado y subida a Google Drive..."

# Limpieza previa y creación de directorio temporal
rm -rf "$BACKUP_TEMP"
mkdir -p "$BACKUP_TEMP"

# Copiamos lo que el módulo generó localmente (base de datos limpia, claves, etc.)
if [ -d "$DATA_DIR" ]; then
    cp -r "$DATA_DIR"/* "$BACKUP_TEMP/"
else
    echo "❌ El directorio de backup local $DATA_DIR no existe. ¿Corrió el servicio nativo?" >&2
    exit 1
fi

# Cifrado y compresión directa usando la variable inyectada por SOPS
tar -cz -C "$BACKUP_TEMP" --exclude="$FILENAME.gpg" . | gpg --batch --yes --passphrase "$BACKUP_PASSPHRASE" \
    --symmetric --cipher-algo AES256 -o "$BACKUP_TEMP/$FILENAME.gpg"

# Subida a la nube
echo "Subiendo archivo cifrado a Google Drive..."
rclone --config="$RCLONE_CONFIG" copy "$BACKUP_TEMP/$FILENAME.gpg" "$REMOTE"

# Sistema de Rotación Nativo (Conserva los respaldos de los últimos 7 días)
echo "Depurando archivos antiguos en el remoto..."
rclone --config="$RCLONE_CONFIG" delete "$REMOTE" --min-age 7d --include "vault_*.tar.gz.gpg"

# Limpieza final de residuos locales
rm -rf "$BACKUP_TEMP"

echo "Respaldo terminado con éxito. Tu base de datos está a salvo en la nube."
