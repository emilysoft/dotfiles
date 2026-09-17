{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  imports = [
    ./yt-dlp.nix
    ./lazygit.nix
  ];

  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      sherlock
      zip
      unzip
      tty-clock
      cava
      ncdu
      unrar
      tree
      jq
      wget
      fzf
      disfetch
      fetch
      qdirstat
      fd
      gh
      ffmpeg
      sorter
      eza
      cmatrix
    ];
  };
}
