{pkgs, ...}: {
  imports = [
    ./neetoons-bot.nix
    ./vscbot.nix
    ./xwayland-satellite.nix
    ./vaultwarden.nix
    ./discord_bots_backup.nix
    ./firefly-iii.nix
  ];

  services = {
    gnome.gcr-ssh-agent.enable = false;
    flatpak.enable = true;
    journald.extraConfig = "SystemMaxUse=500M";

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

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

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
