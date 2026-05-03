{pkgs, ...}: {
  services.swayidle = let
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    enable = true;
    events = {
      before-sleep = "${pkgs.procps}/bin/pkill -STOP mpvpaper; ${pkgs.systemd}/bin/systemctl --user stop gammastep;";
      unlock = "${pkgs.procps}/bin/pkill -CONT mpvpaper; ${pkgs.systemd}/bin/systemctl --user start gammastep";
      after-resume = "${pkgs.procps}/bin/pkill -CONT mpvpaper";
      lock = "${pkgs.procps}/bin/pkill -STOP mpvpaper";
    };

    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 595;
        command = lock;
      }
      {
        timeout = 1200;
        command = display "off";
        resumeCommand = display "on";
      }
    ];
  };
}
