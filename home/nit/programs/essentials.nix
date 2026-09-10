{pkgs, ...}: {
  imports = [
    ./developing/nvim.nix
    ./terminal/alacritty.nix
    ./terminal/yazi.nix
  ];

  home.packages = with pkgs; [
    btop
    sops
    age
    gnupg
    zellij
    rclone
    smile
    tauon
    losslesscut-bin
    proton-vpn
    recorder
    gimp
  ];
}
