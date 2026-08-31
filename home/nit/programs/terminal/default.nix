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
  ];

  config = lib.mkIf enabled {
    programs.rmpc.enable = true;
    home.packages = with pkgs; [
      sherlock
      zip
      unzip
      tty-clock
      cava
      ncdu
      bottom
      unrar
      tree
      jq
      wget
      fzf
      fastfetch
      disfetch
      qdirstat
      fd
      gh
      ffmpeg
      sorter
      eza
      lazygit
      cmatrix
    ];
  };
}
