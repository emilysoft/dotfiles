#!/usr/bin/env bash
set -eo pipefail

REMOTE="nit:Backups/Vaultwarden"
DATA_DIR="/var/local/vaultwarden/backup"
RCLONE_CONFIG="/home/nit/.config/rclone/rclone.conf"
KEEP=7

error_handler() {
    local line_no=$1
    echo "❌ Fallo en el backup (línea $line_no). Revisa journalctl -u vaultwarden-upload-gdrive." >&2
    notify "critical" "❌ Fallo en el Backup" \
        "Hubo un problema en la línea $line_no. Revisa journalctl -u vaultwarden-upload-gdrive."
}

trap 'error_handler $LINENO' ERR

notify() {
    local urgency=$1 title=$2 body=$3

    local user_uid
    user_uid=$(id -u)

    if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${user_uid}/bus"
    fi

    if ! command -v notify-send >/dev/null 2>&1; then
        return 0
    fi

    notify-send -u "$urgency" -t 0 -a "Vaultwarden Backup" "$title" "$body" 2>/dev/null || true
}

DATE=$(date +%Y-%m-%d_%H%M)
FILENAME="vault_${DATE}.tar.gz.gpg"

echo "Iniciando backup de Vaultwarden..."

if [ ! -d "$DATA_DIR" ] || [ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]; then
    notify "critical" "⚠️ Directorio vacío o inexistente" \
        "No hay datos en $DATA_DIR. ¿Corrió backup-vaultwarden.service?"
    exit 1
fi

# icon_cache es solo caché de favicons de vaultwarden (archivos 600 del usuario
# vaultwarden, ilegibles para nit): se excluye. La DB y config son lo que importa.
tar -cz --exclude='./icon_cache' -C "$DATA_DIR" . | gpg --batch --yes --passphrase "$BACKUP_PASSPHRASE" \
    --symmetric --cipher-algo AES256 -o "/tmp/$FILENAME"

echo "Subiendo archivo cifrado a Google Drive..."
rclone --config="$RCLONE_CONFIG" copy "/tmp/$FILENAME" "$REMOTE"

rm -f "/tmp/$FILENAME"

echo "Limpiando versiones antiguas..."
rclone --config="$RCLONE_CONFIG" lsl "$REMOTE" \
    | grep "vault_" \
    | sort -k2,3 \
    | head -n -"$KEEP" | while read -r line; do
        old_file="${line##* }"
        if [ -n "$old_file" ]; then
            rclone --config="$RCLONE_CONFIG" delete "$REMOTE/$old_file"
        fi
    done

notify "normal" "✨ Backup exitoso" "Vaultwarden está respaldado en Google Drive."

echo "✨ Backup de Vaultwarden finalizado con éxito."
