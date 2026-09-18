{
  imports = [
    ./clipboard.nix
    ./clean-cache.nix
    ./clean-trash.nix
    ./sorter.nix
    ./alarmas.nix
  ];

  mis-modulos.alarmas.enable = true;

  services.dunst.enable = true;
  services.hyprpolkitagent.enable = true;
}
