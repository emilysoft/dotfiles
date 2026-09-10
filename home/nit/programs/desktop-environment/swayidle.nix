{pkgs, ...}: {
  services.swayidle = let
    swaylockCmd = "${pkgs.hyprlock}/bin/hyprlock";
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    enable = true;

    events = {
      lock = swaylockCmd;
      before-sleep = "${pkgs.systemd}/bin/loginctl lock-session; ${pkgs.systemd}/bin/systemctl --user stop gammastep";
      unlock = "${pkgs.systemd}/bin/systemctl --user start gammastep";
    };

    timeouts = [
      {
        timeout = 590;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 5000";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        timeout = 1200;
        command = display "off";
        resumeCommand = display "on";
      }
    ];
  };
}
