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
    ./searxng.nix
    ./sanitizer.nix
  ];

  sops.secrets."discord_bots/vscbot/environmentFile" = {};
  services = {
    bancaynegocios-rss.enable = true;
    vscbot = {
      enable = true;
      port = 3006;
      tokenFile = config.sops.secrets."discord_bots/vscbot/environmentFile".path;
      mainServerId = "813538324320092161";
      clientId = "883827073049845801";
    };
  };
}
