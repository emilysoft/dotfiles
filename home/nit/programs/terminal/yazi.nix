{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["y"];
          run = [
            "shell -- for path in %s; do echo \"file://$path\"; done | wl-copy -t text/uri-list"
            "yank"
          ];
          desc = "Copiar archivos seleccionados al portapapeles del sistema";
        }
        {
          on = ["C" "c"];
          run = ["shell -- ffmpeg -i %h -vn -acodec libmp3lame -q:a 2 %h.mp3"];
          desc = "convertir a mp3";
        }
        {
          on = ["c" "a"];
          run = ''shell --confirm "for f in %S; do zip -r \"archived_$(date +%Y%m%d_%H%M%S).zip\" \"$(basename \"$f\")\"; done"'';
          desc = "compress files";
        }
      ];
    };

    settings = {
      yazi = {
        opener = {
          play = [
            {
              run = "${pkgs.mpv}/bin/mpv \"$@\"";
              orphan = true;
              desc = "Play with MPV";
            }
          ];
          edit = [
            {
              run = "${pkgs.neovim}/bin/nvim \"$@\"";
              block = true;
              desc = "Edit with Neovim";
            }
          ];
          image = [
            {
              run = "${pkgs.swayimg}/bin/swayimg \"$@\"";
              orphan = true;
              desc = "Open with swayimg";
            }
          ];
        };

        open = {
          rules = [
            {
              name = "*.mp4";
              use = "play";
            }
            {
              name = "*.mkv";
              use = "play";
            }
            {
              name = "*.png";
              use = "image";
            }
            {
              name = "*.jpg";
              use = "image";
            }
            {
              name = "*.jpeg";
              use = "image";
            }
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    ffmpeg
    poppler
    fd
    fzf
    jq
    wl-clipboard
    file
  ];
}
