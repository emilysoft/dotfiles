{pkgs, ...}: {
  imports = [
    ./niri.nix
    ./eww.nix
    ./swaylock.nix
    ./swayidle.nix
    ./gammastep.nix
    ./mpvpaper.nix
    ./theming.nix
  ];

  home.packages = [
    # pw-play lib
    pkgs.libcanberra
  ];
}
