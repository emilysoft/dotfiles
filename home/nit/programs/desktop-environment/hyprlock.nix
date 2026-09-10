{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inter
  ];

  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          monitor = "";
          path = "${pkgs.assets}/share/assets/wallpapers/afternoon.jpg";
          blur_passes = 0;
        }
      ];

      label = [
        # RELOJ (Gigante y grueso)
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 100;
          font_family = "Inter ExtraBold";
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = "3";
          shadow_size = "15";
          shadow_color = "rgb(0,0,0)";
          shadow_boost = "0.9";
        }
        # FECHA (Arriba del reloj)
        {
          monitor = "";
          text = ''cmd[update:10000] echo "$(date +"%a %d %b.")"'';
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 18;
          font_family = "Inter Bold";
          position = "0, 280";
          halign = "center";
          valign = "center";
          shadow_passes = "3";
          shadow_size = "5";
          shadow_color = "rgb(0,0,0)";
          shadow_boost = "0.2";
        }
      ];

      "input-field" = [
        {
          monitor = "";
          size = "200, 40";
          outline_thickness = 0;
          inner_color = "rgba(255, 255, 255, 0.8)";
          font_color = "rgb(100, 100, 100)";
          dots_size = 0.2;
          dots_spacing = 0.2;
          fade_on_empty = true;
          position = "0, -150";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
