{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    #gtk4.theme = config.gtk.theme;
    gtk4.theme = null;
    iconTheme.package = pkgs.papirus-icon-theme.override {color = "pink";};
    iconTheme.name = "Papirus-Dark";
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        variant = "mocha";
      };
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home.packages = [
    (pkgs.catppuccin-kvantum.override {
      variant = "mocha";
      accent = "mauve";
    })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin-mocha-mauve
  '';

  xdg.configFile."Kvantum/catppuccin-mocha-mauve".source = "${pkgs.catppuccin-kvantum.override {
    variant = "mocha";
    accent = "mauve";
  }}/share/Kvantum/catppuccin-mocha-mauve";

  home.pointerCursor = {
    enable = true;
    package = pkgs.manhattan-cafe;
    name = "ManhattanCafe";
    size = 24;
    gtk.enable = true;
  };
}
