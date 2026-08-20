{
  inputs,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];

  boot.kernelParams = [
    "i915.enable_fbc=1"
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 180; # `(the parameter that defines how aggressively the kernel swaps memory pages to zram)`
    "vm.watermark_boost_factor" = 0; # `(a setting that prevents the system from prematurely reclaiming memory under certain loads)`
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0; # `(controls the number of pages read from swap in a single attempt; 0 is best for zram)`
  };

  boot.plymouth = {
    enable = true;
    theme = "mac-style";
    themePackages = [pkgs.mac-style-plymouth];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4 * 1024;
      priority = 0;
    }
  ];

  systemd.services."dev-ttyS0".enable = false;
}
