{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.spicetify-nix.homeManagerModules.default
    inputs.stylix.homeModules.stylix
    inputs.niri.homeModules.niri
    inputs.nixcord.homeModules.nixcord
    ./programs
    ./mimeapps.nix
    ./services/services.nix
  ];

  #programs
  mis-modulos.profile-principal.enable = true;

  home = {
    username = "nit";
    homeDirectory = "/home/nit";
    stateVersion = "25.11";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "neetoons";
        email = "neet.toons@gmail.com";
      };
    };
  };

  programs.home-manager.enable = true;
  programs.opencode.enable = true;

  home.sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    TERMINAL = "${pkgs.alacritty-graphics}/bin/alacritty";
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
      pkgs.gst_all_1.gstreamer
      pkgs.gst_all_1.gst-plugins-base
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-bad
      pkgs.gst_all_1.gst-plugins-ugly
      pkgs.gst_all_1.gst-libav
    ];
  };
}
