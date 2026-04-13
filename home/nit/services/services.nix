{
  imports = [
    #./waypaper.nix
    ./sunpaper.nix
    ./clipboard.nix
    ./rclone.nix
    ./clean-cache.nix
    ./sorter.nix
    ./discord-rpc-manager.nix
    ./gestor_horario.nix
  ];

  #services.swaync.enable = true;
  services.dunst.enable = true;
}
