{pkgs, ...}: {
  imports = [
    ./niri/niri.nix
    ./eww.nix
    ./swaylock.nix
    ./swayidle.nix
    ./gammastep.nix
    ./theming.nix
  ];

  home.packages = [
    # pw-play lib
    pkgs.libcanberra
  ];

  services.awww.enable = true;
}
