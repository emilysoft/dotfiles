{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.eww = {
    enable = true;
    yuckConfig = builtins.readFile ./eww/eww.yuck;
    scssConfig = builtins.readFile ./eww/eww.scss;
  };

  systemd.user.services.eww = {
    Unit = {
      Description = "EWW Widgets";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
      ExecStartPost = "${pkgs.eww}/bin/eww open-many bar";
      Restart = "on-failure";
      RestartSec = "2s";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
