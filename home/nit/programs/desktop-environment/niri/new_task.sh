#!/usr/bin/env bash

check_cancel() {
    if [ -z "$1" ]; then exit 1; fi
}

TITLE=$(echo "" | fuzzel -d -p "✨ Título: "); check_cancel "$TITLE"
ESFUERZO=$(printf "mucho\npoco" | fuzzel -d -p "✨ Esfuerzo: "); check_cancel "$ESFUERZO"
IMPACTO=$(printf "mucho\npoco" | fuzzel -d -p "✨ Impacto: "); check_cancel "$IMPACTO"
DATE=$(date +"%Y-%m-%dT%H:%M:%S.%3N%:z");
PROYECTO=$(ls -1 "/home/nit/Storage/obsidian_vaults/Tareas/Proyectos/" | sed 's/\.[^.]*$//' | fuzzel -d -p "✨ Proyecto: "); check_cancel "$PROYECTO"
URL=$(echo "" | fuzzel -d -p "✨ URL (opcional): ")
CONTENT=$(echo "" | fuzzel -d -p "📝 Detalles: (opcional)")

BODY="---
nombre: '$TITLE'
status: open
priority: normal
scheduled:
dateCreated: $DATE
dateModified: $DATE
proyecto: $PROYECTO
impacto: $IMPACTO
esfuerzo: $ESFUERZO
URL: $URL
tags:
  - task
---
# $TITLE
[[$PROYECTO - pendientes]]
$CONTENT"

echo "$BODY" > "/home/nit/Storage/obsidian_vaults/Tareas/TaskNotes/Tasks/$TITLE.md"
