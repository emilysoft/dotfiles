{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    dataDir = "/home/nit/jellyfin";
    user = "nit";
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
