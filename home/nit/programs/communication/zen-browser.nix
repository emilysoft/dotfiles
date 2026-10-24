{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  config = lib.mkIf enabled {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles.default.presets.catppuccin = {
        enable = true;
        flavor = "Mocha";
        accent = "Mauve";
      };
    };
  };
}
