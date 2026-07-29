{pkgs, ...}: {
  programs.retroarch = {
    enable = true;

    settings = {
      video_driver = "vulkan";
      aspect_ratio_index = "21";
      sort_savefiles_enable = "true";
      sort_savestates_enable = "true";
    };

    cores = {
      swanstation.enable = true;
      beetle-psx-hw.enable = true;
    };
  };
}
