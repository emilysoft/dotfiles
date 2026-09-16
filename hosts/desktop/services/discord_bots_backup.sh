#!/usr/bin/env bash
set -euo pipefail

REMOTE="nit:Backups/sqlite"
KEEP=3

error_handler() {
    local line_no=$1
    echo "❌ Fallo en el Backup (línea $line_no). El proceso se detuvo." >&2
    notify "critical" "❌ Fallo en el Backup" \
        "Hubo un problema en la línea $line_no. El proceso se detuvo."
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

    notify-send -u "$urgency" -t 0 -a "Bot Backup System" "$title" "$body" 2>/dev/null || true
}

backup_bot() {
    local BOT_NAME=$1
    local DB_PATH="/var/lib/${BOT_NAME}/${BOT_NAME}.db"
    local DATE
    DATE=$(date +%Y-%m-%d_%H%M)

    local BACKUP_TEMP="/tmp/${BOT_NAME}_${DATE}.db"
    local ARCHIVE_TEMP="/tmp/${BOT_NAME}_${DATE}.tar.gz"

    echo "Iniciando backup para: $BOT_NAME..."

    if [ ! -f "$DB_PATH" ]; then
        notify "critical" "⚠️ Archivo no encontrado" \
            "No encontré la DB de $BOT_NAME en $DB_PATH."
        return 1
    fi

    sqlite3 "$DB_PATH" "VACUUM INTO '$BACKUP_TEMP'"

    if tar -czf "$ARCHIVE_TEMP" -C "/tmp" "$(basename "$BACKUP_TEMP")"; then
        rm -f "$BACKUP_TEMP"
    else
        echo "❌ Error comprimiendo $BOT_NAME" >&2
        rm -f "$BACKUP_TEMP"
        return 1
    fi

    rclone move "$ARCHIVE_TEMP" "$REMOTE"

    echo "🧹 Limpiando versiones antiguas de $BOT_NAME..."
    rclone lsf "$REMOTE" --include "${BOT_NAME}_*.tar.gz" | sort | head -n -"$KEEP" | while read -r old_file; do
        if [ -n "$old_file" ]; then
            echo "Eliminando $old_file del remoto..."
            rclone deletefile "$REMOTE/$old_file"
        fi
    done

    notify "normal" "✨ Backup exitoso: $BOT_NAME" \
        "La base de datos de tu bot ya está en el remoto."

    echo "✨ Backup de $BOT_NAME finalizado con éxito."
}

backup_bot "vscbot"
