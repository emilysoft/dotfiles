{pkgs, ...}: let
  backupScript = pkgs.writeShellScriptBin "discord_bots-backup-script" (builtins.readFile ./discord_bots_backup.sh);
in {
  systemd.user.services.discord-bots-backup = {
    description = "Backup rotativo de Discord Bots";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "nit";
    };
    path = with pkgs; [
      sqlite
      rclone
      coreutils
      gzip
      gnutar
    ];
    script = "${backupScript}/bin/discord_bots-backup-script";
    startAt = "04:30"; #after backing up vaultwarden
  };
}
