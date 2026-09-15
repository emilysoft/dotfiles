{
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;

  # 1. Rclone script generator function
  mkRcloneScript = {
    name,
    command,
    src,
    dst,
    logFile,
  }:
    pkgs.writeShellScript "rclone-${name}" ''
      set -euo pipefail

      # Run only if the source directory exists and is not empty
      if [ -d "${src}" ] && [ "$(ls -A "${src}")" ]; then
        echo "[$(date -Iseconds)] Executing ${name} (${command})..." >> "${logFile}"

        ${pkgs.rclone}/bin/rclone ${command} \
          "${src}" \
          "${dst}" \
          --transfers 4 \
          --checkers 8 \
          --tpslimit 8 \
          --tpslimit-burst 10 \
          --fast-list \
          --low-level-retries 10 \
          --drive-skip-gdocs \
          --log-file="${logFile}" \
          --log-level INFO \
          ${
        if command == "move"
        then "--delete-empty-src-dirs --checksum"
        else ""
      }
      fi
    '';

  # 2. Generate executable scripts using the abstraction
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
    logFile = "${homeDir}/.local/state/rclone-daily.log";
  };
in {
  # --- SYSTEMD SERVICES ---

  # Weekly Service (Hot Storage: Mirror cleanup)
  systemd.user.services.rclone-weekly-sync = {
    Unit = {
      Description = "Rclone Weekly Sync (Hot Storage Cleanup)";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${weeklyHotSyncScript}";
    };
  };

  # Daily Service (Cold Storage: Move and purge local copy)
  systemd.user.services.rclone-daily-cold = {
    Unit = {
      Description = "Rclone Daily Cold Storage Move";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${dailyColdMoveScript}";
    };
  };

  # --- SYSTEMD TIMERS ---

  # Weekly Timer (Sundays at 03:00 AM)
  systemd.user.timers.rclone-weekly-sync = {
    Unit.Description = "Timer for Rclone Weekly Hot Sync";
    Timer = {
      OnCalendar = "Sun *-*-* 03:00:00";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };

  # Daily Timer (Every day at 02:00 AM)
  systemd.user.timers.rclone-daily-cold = {
    Unit.Description = "Timer for Rclone Daily Cold Move";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}
