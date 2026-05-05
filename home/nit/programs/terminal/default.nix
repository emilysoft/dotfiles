{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  config = lib.mkIf enabled {
    programs.rmpc.enable = true;
    home.packages = with pkgs; [
      sherlock
      yazi
      zip
      unzip
      tty-clock
      cava
      ncdu
      bottom
      unrar-wrapper
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
      yt-dlp
      sorter
      eza
      lazygit
      cmatrix
      ghostty
    ];
  };
}
