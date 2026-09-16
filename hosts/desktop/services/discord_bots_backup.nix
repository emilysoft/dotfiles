{pkgs, ...}: let
  discordBotsBackup = pkgs.writeShellApplication {
    name = "discord-bots-backup-script";

    runtimeInputs = with pkgs; [
      sqlite
      rclone
      coreutils
      gzip
      gnutar
      gnugrep
      libnotify
    ];

    text = builtins.readFile ./discord_bots_backup.sh;
  };
in {
  systemd.user.services.discord-bots-backup = {
    description = "Backup rotativo de Discord Bots";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${discordBotsBackup}/bin/discord-bots-backup-script";
    };

    startAt = "04:30";
  };
}
