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
      yarn
      pnpm
      bun
      nodejs_latest
      typescript
      python315
      bruno
      sqlitebrowser
      go
    ];
  };
}
