#!/usr/bin/env bash

check_cancel() {
    if [ -z "$1" ]; then exit 1; fi
}

TITLE=$(echo "" | fuzzel -d -p "✨ Título: "); check_cancel "$TITLE"
ESFUERZO=$(printf "mucho\npoco" | fuzzel -d -p "✨ Esfuerzo: "); check_cancel "$ESFUERZO"
IMPACTO=$(printf "mucho\npoco" | fuzzel -d -p "✨ Impacto: "); check_cancel "$IMPACTO"
STATUS=$(printf "Delegada\nInbox\nBloqueado\nEn progreso\nDone" | fuzzel -d -p "✨ Status: "); check_cancel "$STATUS"
PROYECTO=$(ls -1 "/home/nit/Documents/4. Obsidian Vault/Proyectos" | sed 's/\.[^.]*$//' | fuzzel -d -p "✨ Proyecto: "); check_cancel "$PROYECTO"
URL=$(echo "" | fuzzel -d -p "✨ URL (opcional): ")
CONTENT=$(echo "" | fuzzel -d -p "📝 Detalles: (opcional)")

BODY="---
Nombre: '$TITLE'
Esfuerzo: $ESFUERZO
Impacto: $IMPACTO
Proyecto: $PROYECTO
Status: $STATUS
Tipo:
URL: $URL
---
# $TITLE
[[$PROYECTO - pendientes]]
$CONTENT"

echo "$BODY" > "/home/nit/Documents/4. Obsidian Vault/tareas/$TITLE.md"
