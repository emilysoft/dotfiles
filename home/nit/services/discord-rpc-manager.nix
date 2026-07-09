{
  pkgs,
  lib,
  ...
}: let
  src = pkgs.fetchFromGitHub {
    owner = "emilysoft";
    repo = "discord-rpc-manager";
    rev = "main";
    hash = "sha256-Ha73XleAGt0wKAXQ5TVrbAn6ulE4/exxXY20Q6nPIFA=";
  };

  discord-rpc-daemon = pkgs.buildNpmPackage {
    pname = "discord-rpc-daemon";
    version = "1.0.0";
    inherit src;
    sourceRoot = "source/daemon";

    forceGitDeps = true;
    npmDepsHash = "sha256-OR1KKsm6dApyw5TmJgS1az7V+ueZT3m7XSqlXf5m3gA=";

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/discord-rpc-daemon
      cp -r . $out/share/discord-rpc-daemon/
    '';
  };

  discord-rpc-gtk = pkgs.stdenv.mkDerivation {
    pname = "discord-rpc-gtk";
    version = "1.0.0";
    inherit src;

    nativeBuildInputs = [
      pkgs.wrapGAppsHook4
      pkgs.blueprint-compiler
      pkgs.makeWrapper
    ];

    buildInputs = [pkgs.gjs pkgs.gtk4 pkgs.libadwaita];

    buildPhase = ''
      blueprint-compiler compile app/main.blp --output app/main.ui
    '';

    installPhase = ''
      mkdir -p $out/bin $out/share/discord-rpc-gtk
      cp app/main.js app/main.ui $out/share/discord-rpc-gtk/

      makeWrapper ${pkgs.gjs}/bin/gjs $out/bin/discord-rpc-gtk \
        --add-flags "-m $out/share/discord-rpc-gtk/main.js" \
        --set PKG_DATA_DIR "$out/share/discord-rpc-gtk" \
        --prefix GI_TYPELIB_PATH : "$GI_TYPELIB_PATH"
    '';
  };
in {
  home.packages = [discord-rpc-gtk discord-rpc-daemon];

  systemd.user.services.discord-rpc-daemon = {
    Unit = {
      Description = "Discord RPC Mood Manager Daemon";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.tsx}/bin/tsx ${discord-rpc-daemon}/share/discord-rpc-daemon/src/index.ts";
      Environment = "NODE_PATH=${discord-rpc-daemon}/share/discord-rpc-daemon/node_modules";

      Restart = "always";
      RestartSec = "10s";
    };

    Install.WantedBy = ["graphical-session.target"];
  };

  xdg.desktopEntries.discord-rpc-manager = {
    name = "Discord RPC Manager";
    genericName = "Rich Presence Configurator";
    comment = "Configura tu estado de Discord con estilo";
    exec = "discord-rpc-gtk";
    icon = "discord";
    terminal = false;
    categories = ["Settings" "Network"];
    startupNotify = true;
  };
}
