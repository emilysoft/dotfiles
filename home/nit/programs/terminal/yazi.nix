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
