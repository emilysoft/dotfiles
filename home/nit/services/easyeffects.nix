{pkgs, ...}: {
  systemd.user.services.easyeffects = {
    Unit = {
      Description = "easy effects service";
      After = ["graphical-session.target" "pipewire.service"];
      PartOf = ["graphical-session.target" "pipewire.service"];
      Requires = ["dbus.service"];
    };

    Service = {
      ExecStart = "
        ${pkgs.procps}/bin/pkill easyeffects
        ${pkgs.easyeffects}/bin/easyeffects --service-mode
      ";
      Restart = "always";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
