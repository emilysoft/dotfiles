{pkgs, ...}: {
  imports = [
    ./niri/niri.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./gammastep.nix
    ./theming.nix
    ./noctalia.nix
  ];

  home.packages = [
    # pw-play lib
    pkgs.libcanberra
  ];

  services.awww.enable = true;
}
