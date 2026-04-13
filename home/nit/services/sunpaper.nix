{pkgs, ...}: let
  sunpaper-theme = pkgs.runCommand "sunpaper-theme" {} ''
    mkdir -p $out
    cp -L ${pkgs.assets}/share/assets/wallpapers/13.jpg  $out/1.jpg # 05:00 - 06:30 (Amanecer temprano)
    cp -L ${pkgs.assets}/share/assets/wallpapers/8.jpg   $out/2.jpg # 06:30 - 08:00 (Mañana dorada)
    cp -L ${pkgs.assets}/share/assets/wallpapers/7.jpg   $out/3.jpg # 08:00 - 10:30 (Mañana clara)
    cp -L ${pkgs.assets}/share/assets/wallpapers/7.jpg   $out/4.jpg # 10:30 - 16:00 (Pleno día)
    cp -L ${pkgs.assets}/share/assets/wallpapers/1.jpg   $out/5.jpg # 16:00 - 18:30 (Tarde dorada)
    cp -L ${pkgs.assets}/share/assets/wallpapers/15.jpg  $out/6.jpg # 18:30 - 19:30 (Crepúsculo azul)
    cp -L ${pkgs.assets}/share/assets/wallpapers/13.jpg  $out/7.jpg # 19:30 - 21:00 (Anochecer)
    cp -L ${pkgs.assets}/share/assets/wallpapers/13.jpg  $out/8.jpg # 21:00 - 05:00 (Noche profunda)
  '';
in {
  home.packages = [pkgs.sunpaper pkgs.swww pkgs.sunwait];

  xdg.configFile."sunpaper/config".text = ''
    latitude="10.4805N"
    longitude="66.9036W"
    wallpaperPath="${sunpaper-theme}"
    wallpaperMode="fill"
    swww_enable="true"
    swww_fps="60"
    swww_step="2"
  '';

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww daemon";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "always";
    };
    Install = {WantedBy = ["graphical-session.target"];};
  };

  systemd.user.services.sunpaper = {
    Unit = {
      Description = "sunpaper daemon";
      After = ["graphical-session.target" "swww-daemon.service"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.sunpaper}/bin/sunpaper -d";
      Restart = "always";
      RestartSec = "10s";
    };
    Install = {WantedBy = ["graphical-session.target"];};
  };
}
