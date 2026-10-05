{
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;

  mkRcloneScript = {
    name,
    command,
    src,
    dst,
    logFile,
    extraArgs ? [],
  }: let
    baseArgs = [
      command
      "${src}"
      "${dst}"
      "--transfers"
      "4"
      "--checkers"
      "8"
      "--tpslimit"
      "8"
      "--tpslimit-burst"
      "10"
      "--fast-list"
      "--low-level-retries"
      "10"
      "--drive-skip-gdocs"
      "--log-file=${logFile}"
      "--log-level"
      "INFO"
    ];

    commandSpecificArgs =
      if command == "move"
      then ["--delete-empty-src-dirs" "--checksum"]
      else if command == "bisync"
      then [
        "--exclude"
        ".obsidian/workspace.json"
        "--exclude"
        ".obsidian/.trash/**"
      ]
      else [];

    allArgs = baseArgs ++ commandSpecificArgs ++ extraArgs;
    cmdString = builtins.concatStringsSep " \\\n      " allArgs;
  in
    pkgs.writeShellScript "rclone-${name}" ''
      set -euo pipefail

      if [ -d "${src}" ] && [ -n "$(ls -A "${src}")" ]; then
        echo "[$(date -Iseconds)] Executing ${name} (${command})..." >> "${logFile}"
        ${pkgs.rclone}/bin/rclone \
          ${cmdString}
      fi
    '';

  weeklyHotSyncScript = mkRcloneScript {
    name = "hot-sync";
    command = "sync";
    src = "${homeDir}/Storage/hot_storage";
    dst = "nit:Backups/HotStorage";
    logFile = "${homeDir}/.local/state/rclone-weekly.log";
  };

  dailyColdMoveScript = mkRcloneScript {
    name = "cold-move";
    command = "move";
    src = "${homeDir}/Storage/cold_storage";
    dst = "nit:Backups/ColdStorage";
    logFile = "${homeDir}/.local/state/rclone-daily-cold.log";
  };

  dailyObsidianVaultScript = mkRcloneScript {
    name = "obsidian-bisync";
    command = "bisync";
    src = "${homeDir}/Storage/obsidian_vaults";
    dst = "nit:Backups/ObsidianVaults";
    logFile = "${homeDir}/.local/state/rclone-obsidian.log";
  };
in {
  # --- SYSTEMD SERVICES ---

  systemd.user.services.rclone-weekly-sync = {
    Unit.Description = "Rclone Weekly Sync (Hot Storage Cleanup)";
    Service = {
      Type = "oneshot";
      ExecStart = "${weeklyHotSyncScript}";
    };
  };

  systemd.user.services.rclone-daily-cold = {
    Unit.Description = "Rclone Daily Cold Storage Move";
    Service = {
      Type = "oneshot";
      ExecStart = "${dailyColdMoveScript}";
    };
  };

  systemd.user.services.rclone-daily-obsidian-vaults = {
    Unit.Description = "Rclone Daily Obsidian Vaults Bisync";
    Service = {
      Type = "oneshot";
      ExecStart = "${dailyObsidianVaultScript}";
    };
  };

  # --- SYSTEMD TIMERS ---

  systemd.user.timers.rclone-weekly-sync = {
    Unit.Description = "Timer for Rclone Weekly Hot Sync";
    Timer = {
      OnCalendar = "Sun *-*-* 03:00:00";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };

  systemd.user.timers.rclone-daily-cold = {
    Unit.Description = "Timer for Rclone Daily Cold Move";
    Timer = {
      OnCalendar = "*-*-* 02:00:00"; # 02:00 AM real
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };

  systemd.user.timers.rclone-daily-obsidian-vaults = {
    Unit.Description = "Timer for Rclone Daily Obsidian Vaults Sync";
    Timer = {
      OnCalendar = "*:0/30"; # Ejecutar cada 30 minutos
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}
