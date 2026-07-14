{
  pkgs,
  config,
  ...
}: let
  volume_control = "${pkgs.assets}/share/assets/sounds/volume_control.mp3";
  new_task = pkgs.writeShellScriptBin "custom-action" (builtins.readFile ./new_task.sh);
in {
  programs.niri.settings.binds = {
    # Aplicaciones y Comandos
    "Mod+I".action.spawn-sh = ["${pkgs.swaylock}/bin/swaylock --daemonize"];
    "Mod+O".action.spawn = [
      "${pkgs.lib.getExe new_task}"
    ];
    "Mod+Shift+P".action.spawn-sh = ["echo '' | fuzzel --dmenu | xargs -I{} xdg-open 'https://thepiratebay.org/search.php?q={}&video=on'"];
    "Mod+1".action.spawn-sh = ["niri msg action set-dynamic-cast-window --id $(niri msg --json pick-window | jq .id) &"];
    "Mod+2".action.spawn-sh = ["niri msg action set-dynamic-cast-window"];
    "Mod+3".action.spawn-sh = ["niri msg action set-dynamic-cast-monitor"];
    "Mod+Y".action.spawn-sh = ["echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://www.youtube.com/results?search_query={}"];
    "Mod+B".action.spawn-sh = ["xdg-open https://www.youtube.com/feed/history"];
    "Mod+D".action.spawn-sh = ["xdg-open ${config.xdg.configHome}/Downloads"];
    "Mod+M".action.spawn-sh = ["${pkgs.wtype}/bin/wtype '/warn usuario: razon:'"];
    "Mod+Shift+Y".action.spawn-sh = ["xdg-open https://www.youtube.com/playlist?list=LL"];

    "Mod+S".action.spawn-sh = ["fuzzel"];
    "Mod+Shift+S".action.spawn-sh = ["smile"];

    "Mod+E".action.spawn-sh = ["alacritty -e yazi"];
    "Mod+Shift+E".action.spawn-sh = ["thunar"];
    "Mod+X".action.spawn-sh = ["alacritty"];
    "Mod+Shift+X".action.spawn-sh = ["alacritty -e zellij"];
    "Mod+T".action.spawn-sh = ["cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"];
    "Mod+KP_Up".action.spawn-sh = ["wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0 && pw-play ${volume_control}"];
    "Mod+KP_Down".action.spawn-sh = ["wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pw-play ${volume_control}"];

    # Navegación y Layout

    "Mod+Space".action.toggle-overview = {};
    "Mod+Q".action.close-window = {};
    "Mod+Left".action.focus-column-left = {};
    "Mod+Right".action.focus-column-right = {};
    "Mod+H".action.focus-column-left = {};
    "Mod+L".action.focus-column-right = {};
    "Mod+J".action.focus-window-or-workspace-down = {};
    "Mod+K".action.focus-window-or-workspace-up = {};
    "Mod+Up".action.focus-window-or-workspace-up = {};
    "Mod+Down".action.focus-window-or-workspace-down = {};
    "Mod+Shift+J".action.move-column-to-workspace-down = {};
    "Mod+Shift+K".action.move-column-to-workspace-up = {};
    "Mod+BracketLeft".action.consume-or-expel-window-left = {};
    "Mod+BracketRight".action.consume-or-expel-window-right = {};

    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    "Mod+V".action.toggle-window-floating = [];
    "Mod+W".action.toggle-column-tabbed-display = {};
    "Mod+Shift+H".action.move-column-left = {};
    "Mod+Shift+L".action.move-column-right = {};

    "Mod+Shift+Left".action.move-column-left = {};
    "Mod+Shift+Right".action.move-column-right = {};
    "Mod+C".action.center-column = {};

    "Mod+R".action.switch-preset-column-width = {};
    "Mod+Shift+R".action.switch-preset-window-height = {};
    "Mod+Ctrl+R".action.reset-window-height = {};
    "Mod+F".action.maximize-column = {};
    "Mod+Shift+F".action.fullscreen-window = {};

    # gammastep
    "Mod+Shift+1".action.spawn-sh = ["${pkgs.systemd}/bin/systemctl --user start gammastep"];
    "Mod+Shift+2".action.spawn-sh = ["${pkgs.systemd}/bin/systemctl --user stop gammastep"];

    "Mod+wheelscrollup".action.focus-column-left = {};
    "Mod+wheelscrolldown".action.focus-column-right = {};

    #"Mod+Shift+wheelscrolldown".action.focus-window-or-workspace-down = { cooldown-ms=150;};
    "Mod+Shift+wheelscrollup".action.focus-column-right = {};
    "Mod+Shift+wheelscrolldown".action.focus-window-or-workspace-down = {};

    # Capturas
    "Mod+P".action.spawn-sh = ["recorder"];
    "Print".action.screenshot = {};
    "Mod+Print".action.spawn-sh = ["mkdir -p ${config.xdg.configHome}/Pictures/screenshots && grim -t png -g \"$(slurp)\" - | satty --filename - -o ~/Pictures/screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"];
    "Mod+Ctrl+Print".action.spawn-sh = ["mkdir -p ${config.xdg.configHome}/Pictures/screenshots && grim -g \"0,0 1440x900\" - | tee ~/Pictures/screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"];

    # Utilidades Nix/Web
    "Mod+G".action.spawn-sh = ["echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://www.google.com/search?q={}"];
    "Mod+Shift+G".action.spawn-sh = ["xdg-open https://gemini.google.com"];
    "Mod+N".action.spawn-sh = ["echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://search.nixos.org/packages?query={}"];
    "Mod+Shift+N".action.spawn-sh = ["echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://search.nixos.org/options?query={}"];

    # Control de Reproducción
    "Mod+KP_Right".action.spawn-sh = ["playerctl next"];
    "Mod+KP_Left".action.spawn-sh = ["playerctl previous"];
    "Mod+KP_Begin".action.spawn-sh = ["playerctl play-pause"];

    "Mod+Shift+Q".action.quit = {};
    "Ctrl+Alt+Delete".action.quit = {};
  };
}
