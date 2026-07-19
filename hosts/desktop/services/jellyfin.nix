{pkgs, ...}: {
  services.jellyfin = {
    enable = true;

    user = "jellyfin";
    group = "jellyfin";

    hardwareAcceleration = {
      enable = true;
      type = "vaapi";
      device = "/dev/dri/renderD128";
    };

    forceEncodingConfig = true;
    transcoding = {
      enableHardwareEncoding = true;
      throttleTranscoding = true;

      hardwareDecodingCodecs = {
        h264 = true;
        mpeg2 = true;
      };
    };
  };

  users.users.jellyfin.extraGroups = ["users"];
}
