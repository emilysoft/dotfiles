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
    systemd.enable = true;
  };

  systemd.user.services.eww = {
    Service = {
      ExecStartPost = "${pkgs.eww}/bin/eww open-many bar";
      Restart = "on-failure";
      RestartSec = "2s";
    };
  };

  home.file.".config/eww/scripts/vscbot" = {
    source = ./eww/scripts/vscbot;
    executable = true;
  };

  home.file.".config/eww/scripts/network" = {
    source = ./eww/scripts/network;
    executable = true;
  };
}
