{pkgs, ...}: {
  systemd.user.services.clean-trash = {
    Unit.Description = "Clean user trash directory";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/rm -rf %h/.local/share/Trash/files/* %h/.local/share/Trash/info/*'";
    };
  };

  systemd.user.timers.clean-trash = {
    Unit.Description = "Clean user trash daily";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}
