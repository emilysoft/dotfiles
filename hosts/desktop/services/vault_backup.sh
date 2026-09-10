#!/usr/bin/env bash
set -e

REMOTE="nit:Backups/Vaultwarden"
DATA_DIR="/var/local/vaultwarden/backup"
RCLONE_CONFIG="/home/nit/.config/rclone/rclone.conf"

error_handler() {
    local line_no=$1
    notify-send -u critical -t 0 -a "Vaultwarden Backup" \
        "❌ Fallo en el Backup" \
        "Hubo un problema en la línea $line_no. Revisa journalctl -u vaultwarden-upload-gdrive."
}

trap 'error_handler $LINENO' ERR

DATE=$(date +%Y-%m-%d_%H%M)
FILENAME="vault_${DATE}.tar.gz.gpg"
BACKUP_TEMP="/tmp/vaultwarden_${DATE}"

echo "Iniciando backup de Vaultwarden..."

if [ ! -d "$DATA_DIR" ] || [ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]; then
    notify-send -u critical -t 0 -a "Vaultwarden Backup" \
        "⚠️ Directorio vacío o inexistente" \
        "No hay datos en $DATA_DIR. ¿Corrió backup-vaultwarden.service?"
    exit 1
fi

mkdir -p "$BACKUP_TEMP"
cp -r "$DATA_DIR"/* "$BACKUP_TEMP/"

tar -cz -C "$BACKUP_TEMP" . | gpg --batch --yes --passphrase "$BACKUP_PASSPHRASE" \
    --symmetric --cipher-algo AES256 -o "/tmp/$FILENAME"

rm -rf "$BACKUP_TEMP"

echo "Subiendo archivo cifrado a Google Drive..."
rclone --config="$RCLONE_CONFIG" copy "/tmp/$FILENAME" "$REMOTE"

rm -f "/tmp/$FILENAME"

echo "Limpiando versiones antiguas..."
rclone --config="$RCLONE_CONFIG" lsl "$REMOTE" | grep "vault_" | sort -k2,3 | head -n -7 | awk '{print $NF}' | while read -r old_file; do
    if [ -n "$old_file" ]; then
        rclone --config="$RCLONE_CONFIG" delete "$REMOTE/$old_file"
    fi
done

notify-send -u normal -t 0 -a "Vaultwarden Backup" \
    "✨ Backup exitoso" \
    "Vaultwarden está respaldado en Google Drive."

echo "✨ Backup de Vaultwarden finalizado con éxito."
