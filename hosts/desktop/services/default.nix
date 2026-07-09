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
    ./podman.nix
  ];

  sops.secrets."discord_bots/vscbot/environmentFile" = {};
  services = {
    gnome.gcr-ssh-agent.enable = false;
    flatpak.enable = true;
    journald.extraConfig = "SystemMaxUse=500M";

    mpd = {
      enable = true;
      settings = {
        music_directory = "/home/nit/Music";
        audio_output = [
          {
            type = "pipewire";
            name = "PipeWire Output";
          }
        ];
      };
    };

    vscbot = {
      enable = true;
      port = 3006;
      tokenFile = config.sops.secrets."discord_bots/vscbot/environmentFile".path;
      mainServerId = "813538324320092161";
      clientId = "883827073049845801";
    };
  };
}
