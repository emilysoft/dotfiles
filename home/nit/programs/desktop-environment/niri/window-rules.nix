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
        {app-id = "obsidian";}
        {app-id = "qbittorrent";}
        {app-id = "elisa";}
      ];
      default-column-width = {proportion = 1.0;};
    }
    {
      matches = [{app-id = "samp.exe";}];
      open-floating = false;
    }
    {
      matches = [{app-id = "^org\\.wezfurlong\\.wezterm$";}];
      default-column-width = {};
    }
    {
      matches = [
        {app-id = "smile$";}
      ];
      open-floating = true;
      default-column-width = {fixed = 316;};
      default-window-height = {fixed = 410;};
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
  ];
}
