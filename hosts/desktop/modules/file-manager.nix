{pkgs, ...}: let
in {
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];
  environment.systemPackages = [pkgs.file-roller pkgs.unrar];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  xdg.portal.config.preferred."org.freedesktop.impl.portal.FileChooser" = "thunar";
}
