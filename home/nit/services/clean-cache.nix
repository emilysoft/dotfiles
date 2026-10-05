{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.clean-cache = {
    Unit = {
      Description = "Clean Spotify and Thunar cache storage";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "clean-cache" ''
        set -euo pipefail

        clean_directory() {
          local dir="$1"
          local label="$2"

          echo "Iniciando la limpieza de: $label ($dir)"
          if [ -d "$dir" ]; then
            ${pkgs.findutils}/bin/find "$dir" -mindepth 1 -delete
            echo "Limpieza de $label completada con éxito."
          else
            echo "Aviso: El directorio $dir no existe."
          fi
        }

        clean_directory "${config.home.homeDirectory}/.cache/spotify/Browser/Cache" "Spotify Cache"
        clean_directory "${config.home.homeDirectory}/.cache/thumbnails" "Thunar Thumbnails"
      ''}";
    };
  };

  systemd.user.timers.clean-cache = {
    Unit.Description = "Timer to clean Spotify and Thunar cache daily";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}
