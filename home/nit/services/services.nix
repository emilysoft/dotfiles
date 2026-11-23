{
  imports = [
    ./clipboard.nix
    ./clean-cache.nix
    ./clean-trash.nix
    ./sorter.nix
    ./alarmas.nix
    ./backups.nix
  ];

  mis-modulos.alarmas.enable = true;
  services.hyprpolkitagent.enable = true;
}
