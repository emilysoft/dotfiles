{pkgs, ...}: {
  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        default.path = "${pkgs.assets}/share/assets/wallpapers/afternoon.jpg";
      };
    };
  };
}
