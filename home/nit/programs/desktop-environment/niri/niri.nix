{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./binds.nix
    ./window-rules.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      includes = lib.mkAfter [
        (./blur.kdl)
      ];
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "intl";
          };
          numlock = true;
        };
      };

      #hot-corners.enable = false;

      cursor = {
        hide-when-typing = true;
        hide-after-inactive-ms = 1000;
      };

      outputs."eDP-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 120.030;
        };
        scale = 2.0;
        position = {
          x = 1280;
          y = 0;
        };
      };

      layout = {
        gaps = 12;
        center-focused-column = "never";
        default-column-width = {proportion = 0.5;};

        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
        ];

        focus-ring.enable = false;

        border = {
          width = 1;
          active.color = "#ffffff00";
          inactive.color = "#000000ff"; # Recomiendo 8 dígitos para evitar ambigüedad
        };

        shadow = {
          softness = 7;
          spread = 4;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#00000080";
        };
      };

      spawn-at-startup = [
        {command = ["${pkgs.smile}/bin/smile --start-hidden"];}
        {command = ["${pkgs.fcitx5}/bin/fcitx5 -d --replace"];}
      ];

      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      hotkey-overlay.skip-at-startup = true;
      animations = {
        slowdown = 0.0;
      };
    };
  };
}
