{
  inputs,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest-x86_64-v3;
  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["i915.enable_fbc=1" "i915.enable_guc=2"];

  boot.kernel.sysctl = {
    "vm.swappiness" = 180; # `(the parameter that defines how aggressively the kernel swaps memory pages to zram)`
    "vm.watermark_boost_factor" = 0; # `(a setting that prevents the system from prematurely reclaiming memory under certain loads)`
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0; # `(controls the number of pages read from swap in a single attempt; 0 is best for zram)`
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
      size = 8 * 1024;
      priority = 0;
    }
  ];
}
