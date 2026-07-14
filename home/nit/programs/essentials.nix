{pkgs, ...}: {
  imports = [
    ./developing/nvim.nix
    ./terminal/alacritty.nix
    ./terminal/yazi.nix
  ];

  home.packages = with pkgs; [
    btop # Monitor de recursos del sistema con una interfaz visual y atractiva
    sops
    age
    gnupg
    zellij
    rclone # Herramienta de sincronización de archivos con servicios de almacenamiento en la nube
    smile
    tauon
    losslesscut-bin
    proton-vpn
    waypaper
    recorder
  ];
}
