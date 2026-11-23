{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      bleachbit
      contrast
      qbittorrent
      tor-browser
      stremio-linux-shell
      wordbook
      gnome-pomodoro
      (alpaca.overrideAttrs (old: {
        propagatedBuildInputs =
          (old.propagatedBuildInputs or [])
          ++ [
            python3Packages.pandas
            python3Packages.pygobject3
          ];
      }))
    ];
  };
}
