{
  imports = [
    ./waypaper.nix
    ./clipboard.nix
    ./clean-cache.nix
    ./sorter.nix
    ./discord-rpc-manager.nix
    ./alarmas.nix
  ];

  mis-modulos.alarmas.enable = true;

  services.dunst.enable = true;
}
