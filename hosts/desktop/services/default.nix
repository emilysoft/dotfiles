{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ssh.nix
    ./xwayland-satellite.nix
    ./vaultwarden.nix
    ./discord_bots_backup.nix
    ./firefly-iii.nix
    ./jellyfin.nix
  ];

  sops.secrets."discord_bots/vscbot/environmentFile" = {};
  services = {
    gnome.gcr-ssh-agent.enable = false;
    journald.extraConfig = "SystemMaxUse=500M";

    vscbot = {
      enable = true;
      port = 3006;
      tokenFile = config.sops.secrets."discord_bots/vscbot/environmentFile".path;
      mainServerId = "813538324320092161";
      clientId = "883827073049845801";
    };
  };
}
