{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.mis-modulos.profile-principal;
in {
  options.mis-modulos = {
    media = {enable = mkEnableOption "Media applications";};
    profile-principal = {enable = mkEnableOption "My applications profile";};
  };

  imports = [
    ./essentials.nix
    ./communication
    ./desktop-environment
    ./developing
    ./utilities
    ./gaming
    ./media
    ./office
    ./terminal
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
      inputs.concord.packages.${system}.default
      inputs.elyprism.packages.${system}.default
    ];
  };
}
