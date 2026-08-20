{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
