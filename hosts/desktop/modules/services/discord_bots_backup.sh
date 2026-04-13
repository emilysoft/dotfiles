#!/usr/bin/env bash
set -e

REMOTE="nit:Backups/sqlite"

# Función estética para errores
error_handler() {
    local line_no=$1
    notify-send -u critical -t 0 -a "Bot Backup System" \
        "❌ Fallo en el Backup" \
        "Hubo un problema en la línea $line_no. El proceso se detuvo."
}

# Trap para capturar cualquier error antes de morir
trap 'error_handler $LINENO' ERR

backup_bot() {
    local BOT_NAME=$1
    local DB_PATH="/var/lib/discord-bots/${BOT_NAME}-db/${BOT_NAME}.db"
    local DATE=$(date +%Y-%m-%d_%H%M)
    local FILENAME="${BOT_NAME}_${DATE}.tar.gz"
    local BACKUP_TEMP="/tmp/${BOT_NAME}_${DATE}.db"

    echo "Iniciando backup para: $BOT_NAME..."

    if [ ! -f "$DB_PATH" ]; then
        notify-send -u critical -t 0 -a "Bot Backup System" \
            "⚠️ Archivo no encontrado" \
            "No encontré la DB de $BOT_NAME en el path especificado."
        return 1
    fi

    # Usamos VACUUM INTO (`una operación de SQLite que crea una copia consistente de la base de datos sin bloquearla`)
    sqlite3 "$DB_PATH" "VACUUM INTO '$BACKUP_TEMP'"

    if tar -czf "$FILENAME" -C "/tmp" "$(basename "$BACKUP_TEMP")"; then
        rm "$BACKUP_TEMP"
    else
        echo "❌ Error comprimiendo $BOT_NAME"
        return 1
    fi

    rclone move "$FILENAME" "$REMOTE"

    echo "🧹 Limpiando versiones antiguas de $BOT_NAME..."
    rclone lsl "$REMOTE" | grep "${BOT_NAME}_" | sort -k2,3 | head -n -3 | awk '{print $NF}' | while read -r old_file; do
        if [ -n "$old_file" ]; then
            rclone delete "$REMOTE/$old_file"
        fi
    done

    # Notificación de éxito persistente
    notify-send -u normal -t 0 -a "Bot Backup System" \
        "✨ Backup exitoso: $BOT_NAME" \
        "La base de datos de tu bot ya está en el remoto."

    echo "✨ Backup de $BOT_NAME finalizado con éxito."
}

backup_bot "vscbot"
