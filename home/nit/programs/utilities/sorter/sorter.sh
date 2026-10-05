#!/bin/bash

TIEMPO_MINIMO_SEGUNDOS=900

es_archivo_antiguo_minimo() {
  local archivo="$1"
  local tiempo_minimo="$2"

  local mtime_epoch
  mtime_epoch=$(stat -c %Y "$archivo")
  local tiempo_actual_epoch
  tiempo_actual_epoch=$(date +%s)
  local antiguedad=$((tiempo_actual_epoch - mtime_epoch))

  if [ "$antiguedad" -ge "$tiempo_minimo" ]; then
    return 0
  else
    return 1
  fi
}

mover_seguro() {
  local origen="$1"
  local destino_dir="$2"
  local nombre_archivo
  nombre_archivo=$(basename "$origen")
  local destino="$destino_dir/$nombre_archivo"

  local nombre_base="${nombre_archivo%.*}"
  local extension="${nombre_archivo##*.}"
  local contador=1
  local nuevo_destino="$destino"

  if [ "$nombre_base" = "$nombre_archivo" ]; then
    extension=""
  else
    extension=".$extension"
  fi

  while [ -e "$nuevo_destino" ]; do
    nuevo_nombre="${nombre_base}(${contador})${extension}"
    nuevo_destino="$destino_dir/$nuevo_nombre"
    contador=$((contador + 1))
  done

  mv "$origen" "$nuevo_destino"
}

# 3. CREACIÓN DE DIRECTORIOS
mkdir -p "1_Video"
mkdir -p "2_Images/PSD"
mkdir -p "2_Images/gif"
mkdir -p "3_Archives"
mkdir -p "4_Documents/Word"
mkdir -p "4_Documents/Excel"
mkdir -p "4_Documents/PDF"
mkdir -p "Scripts/JavaScript"
mkdir -p "Scripts/Bash"
mkdir -p "Scripts/Batch"
mkdir -p "Scripts/Lua"
mkdir -p "Scripts/Python"
mkdir -p "Scripts/AutoHotkey"
mkdir -p "Scripts/Pawn"
mkdir -p "7_Executables"
mkdir -p "Database"
mkdir -p "Torrents"
mkdir -p "Links"
mkdir -p "5_Audio"
mkdir -p "Miscellaneous"
mkdir -p "6_TextFiles"
mkdir -p "WebFiles"
mkdir -p "GameFiles/SAMP"
mkdir -p "GameFiles/Other"
mkdir -p "3DModels"

# 4. MOVIMIENTO DE ARCHIVOS
for file in *; do
  if [ -f "$file" ] && [ "$file" != "$(basename "$0")" ]; then

    if es_archivo_antiguo_minimo "$file" "$TIEMPO_MINIMO_SEGUNDOS"; then

      case "${file,,}" in
      # Archivos de Word
      *.docx | *.rtf)
        mover_seguro "$file" "4_Documents/Word"
        ;;
      # Archivos de Excel
      *.xlsx | *.xlsm | *.xls)
        mover_seguro "$file" "4_Documents/Excel"
        ;;
      # PDF y Ebook
      *.pdf | *.epub)
        mover_seguro "$file" "4_Documents/PDF"
        ;;
      # Imágenes
      *.webp | *.png | *.apng | *.bmp | *.jpg | *.jpeg)
        mover_seguro "$file" "2_Images"
        ;;
      # GIF
      *.gif)
        mover_seguro "$file" "2_Images/gif"
        ;;
      *.psd)
        mover_seguro "$file" "2_Images/PSD"
        ;;
      # Scripts
      *.js | *.ts | *.tsx)
        mover_seguro "$file" "Scripts/JavaScript"
        ;;
      *.sh)
        mover_seguro "$file" "Scripts/Bash"
        ;;
      *.bat | *.cmd)
        mover_seguro "$file" "Scripts/Batch"
        ;;
      *.lua)
        mover_seguro "$file" "Scripts/Lua"
        ;;
      *.py)
        mover_seguro "$file" "Scripts/Python"
        ;;
      *.ahk)
        mover_seguro "$file" "Scripts/AutoHotkey"
        ;;
      *.pwn | *.amx | *.inc | *.sma)
        mover_seguro "$file" "Scripts/Pawn"
        ;;
      # Archivos comprimidos
      *.7z | *.zip | *.rar | *.tar.xz | *.tgz | *.pack | *.gz)
        mover_seguro "$file" "3_Archives"
        ;;
      # Ejecutables/Binarios
      *.exe | *.dll | *.jar | *.deb | *.apk | *.msi | *.ico | *.install | *.setup)
        mover_seguro "$file" "7_Executables"
        ;;
      # Bases de Datos
      *.sql | *.kdbx)
        mover_seguro "$file" "Database"
        ;;
      # Torrents
      *.torrent)
        mover_seguro "$file" "Torrents"
        ;;
      # Enlaces
      *.url | *.lnk | *.desktop)
        mover_seguro "$file" "Links"
        ;;
      # Audio
      *.wav | *.mp3)
        mover_seguro "$file" "5_Audio"
        ;;
      # Video
      *.mp4 | *.mkv | *.mov | *.webm | *.ogg)
        mover_seguro "$file" "1_Video"
        ;;
      # Archivos de texto
      *.txt | *.md | *.log | *.ini | *.json | *.yml | *.rules | *.ps1 | *.csv)
        mover_seguro "$file" "6_TextFiles"
        ;;
      # Archivos Web
      *.html | *.php | *.webmanifest | *.css | *.opml)
        mover_seguro "$file" "WebFiles"
        ;;
      # Archivos de Juego
      *.dff | *.txd | *.rec | *.asi)
        mover_seguro "$file" "GameFiles/SAMP"
        ;;
      # Modelos 3D
      *.blend)
        mover_seguro "$file" "3DModels"
        ;;
      # Misceláneos
      *)
        mover_seguro "$file" "Miscellaneous"
        ;;
      esac
    fi
  fi
done

# 5. LIMPIEZA
find . -mindepth 1 -depth -type d -empty -delete
