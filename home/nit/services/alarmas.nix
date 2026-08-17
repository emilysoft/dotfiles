{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.mis-modulos.alarmas;
in {
  options.mis-modulos.alarmas = {
    enable = lib.mkEnableOption "Alarmas por CSV";
    file = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.config/alarmas/alarmas.csv";
      description = "Ruta al archivo CSV con las alarmas (formato HH:MM,días,mensaje).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.activation.crear-csv-alarmas = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "$(dirname "${cfg.file}")"
      if [ ! -f "${cfg.file}" ]; then
        cat > "${cfg.file}" <<'EOF'
08:00,1-5,¡Es hora de despertar!
12:30,*,¡Hora de comer!
15:00,6,¡Partida!
EOF
      fi
    '';

    systemd.user.services.alarmas = {
      Unit = {
        Description = "Alarmas por CSV";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "alarmas" ''
          CSV_FILE="${cfg.file}"

          [ -n "$WAYLAND_DISPLAY" ] || [ -n "$DISPLAY" ] || exit 0
          [ -f "$CSV_FILE" ] || exit 0

          NOW=$(${pkgs.coreutils}/bin/date +%H:%M)
          DIA=$(${pkgs.coreutils}/bin/date +%w)

          match_day() {
            local spec="$1" r start end
            [ "$spec" = "*" ] && return 0
            IFS=',' read -ra ranges <<< "$spec"
            for r in "''${ranges[@]}"; do
              if [[ "$r" == *-* ]]; then
                start="''${r%%-*}"; end="''${r##*-}"
              else
                start="$r"; end="$r"
              fi
              if [ "$DIA" -ge "$start" ] && [ "$DIA" -le "$end" ]; then
                return 0
              fi
            done
            return 1
          }

          while IFS= read -r linea; do
            linea="''${linea#$(printf '\xef\xbb\xbf')}"
            linea="''${linea%$'\r'}"
            [ -z "$linea" ] && continue
            case "$linea" in
              '#'*) continue ;;
            esac

            field=0; buf=""; in_q=0
            i=0; n=''${#linea}
            while [ "$i" -lt "$n" ]; do
              c="''${linea:$i:1}"
              if [ "$in_q" = "1" ]; then
                if [ "$c" = '"' ]; then
                  if [ $((i + 1)) -lt "$n" ] && [ "''${linea:$((i + 1)):1}" = '"' ]; then
                    buf="''${buf}\""
                    i=$((i + 1))
                  else
                    in_q=0
                  fi
                else
                  buf="''${buf}''${c}"
                fi
              elif [ "$c" = '"' ]; then
                in_q=1
              elif [ "$c" = ',' ]; then
                printf -v "campo_$field" '%s' "$buf"
                field=$((field + 1))
                buf=""
              else
                buf="''${buf}''${c}"
              fi
              i=$((i + 1))
            done
            printf -v "campo_$field" '%s' "$buf"

            hora="''${campo_0:-}"
            dias="''${campo_1:-}"
            mensaje="''${campo_2:-}"

            [ -z "$hora" ] || [ -z "$mensaje" ] && continue
            [ -z "$dias" ] && dias="*"

            case "$hora" in
              ?:*) hora="0$hora" ;;
            esac

            if [ "$hora" = "$NOW" ] && match_day "$dias"; then
              ${pkgs.libnotify}/bin/notify-send "Alarma" "$mensaje" -u critical
            fi
          done < "$CSV_FILE"
        ''}";
      };
    };

    systemd.user.timers.alarmas = {
      Unit.Description = "Timer para alarmas por CSV";
      Timer = {
        OnCalendar = "minutely";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
