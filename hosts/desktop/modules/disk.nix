{pkgs, ...}: {
  # Bootloader
  boot.loader.timeout = 3;
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # Storage optimization
  nix = {
    settings = {
      download-buffer-size = 524288000;
      auto-optimise-store = false;

      # network throttling control
      http2 = false;
      http-connections = 2;
      max-jobs = 1;
      cores = 0;
      connect-timeout = 60;
      stalled-download-timeout = 90;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["Sun 04:00"];
    };
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  # smart
  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/sda";
      }
    ];
  };
}
