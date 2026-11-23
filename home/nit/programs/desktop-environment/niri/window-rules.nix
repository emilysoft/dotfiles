{
  pkgs,
  config,
  ...
}: {
  programs.niri.settings.window-rules = [
    {
      matches = [
        {app-id = "steam";}
        {app-id = "vesktop";}
        {app-id = "discord";}
        {app-id = "spotify";}
        {app-id = "ferdium";}
        {app-id = "thunar";}
        {app-id = "zen-beta";}
        {app-id = "Alacritty";}
        {app-id = "easyeffects";}
        {app-id = "lutris";}
        {app-id = "Tauon";}
        {app-id = "qbittorrent";}
        {app-id = "swayimg";}
      ];
      default-column-width = {proportion = 1.0;};
    }
    {
      matches = [{app-id = "obsidian";}];
      open-fullscreen = true;
    }
    {
      matches = [
        {app-id = "vesktop";}
        {app-id = "proton";}
      ];
      open-floating = false;
    }
    {
      open-floating = true;
      matches = [
        {
          title = "^Picture-in-Picture$";
        }
      ];
    }
    {
      geometry-corner-radius = {
        top-left = 20.0;
        top-right = 20.0;
        bottom-left = 10.0;
        bottom-right = 10.0;
      };
      clip-to-geometry = true;
    }
    {
      matches = [{is-window-cast-target = true;}];
      focus-ring = {
        active.color = "#f38ba8";
        inactive.color = "#7d0d2d";
      };
      border.inactive.color = "#7d0d2d";
      shadow.color = "#7d0d2d70";
    }
    {
      matches = [
        {
          app-id = "steam";
          title = "^notificationtoasts_\\d+_desktop$";
        }
        {app-id = "wineboot";}
      ];
      open-focused = false;
      default-floating-position = {
        x = 0;
        y = 0;
        relative-to = "bottom-right";
      };
    }
  ];
}
