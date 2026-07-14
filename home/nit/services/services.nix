{
  imports = [
    ./waypaper.nix
    ./clipboard.nix
    ./clean-cache.nix
    ./sorter.nix
    ./discord-rpc-manager.nix
  ];

  services.dunst.enable = true;
}
