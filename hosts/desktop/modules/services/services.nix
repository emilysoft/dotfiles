{pkgs, ...}: {
  imports = [
    ./neetoons-bot.nix
    ./vscbot.nix
    ./xwayland-satellite.nix
    ./vaultwarden.nix
    ./discord_bots_backup.nix
  ];

  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    gnome.gcr-ssh-agent.enable = false;
    flatpak.enable = true;
    journald.extraConfig = "SystemMaxUse=500M";
  };
}
