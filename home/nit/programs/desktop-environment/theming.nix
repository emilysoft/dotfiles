{pkgs, ...}: {
  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme.package = pkgs.papirus-icon-theme.override {color = "pink";};
    iconTheme.name = "Papirus-Dark";
  };

  home.pointerCursor = {
    package = pkgs.manhattan-cafe;
    name = "ManhattanCafe";
    size = 24;
    gtk.enable = true;
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets.mangohud.enable = false;
    targets.vesktop.enable = false;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.geist-font;
        name = "Geist Sans";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist Sans";
      };

      monospace = {
        package = pkgs.geist-font;
        name = "Geist Sans";
      };
      emoji = {
        #package = pkgs.twitter-color-emoji;
        package = pkgs.joypixels;
        #name = "Twitter Color Emoji";
        name = "joypixels";
      };
    };
  };
}
