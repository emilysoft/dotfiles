{
  config,
  lib,
  ...
}: let
  hotStorageDir = "${config.home.homeDirectory}/Storage/hot_storage";

  userDirs = {
    "Documents" = "1_Documents";
    "Pictures" = "2_Pictures";
    "Videos" = "3_Videos";
  };
in {
  home.file =
    lib.mapAttrs' (homeName: targetName: {
      name = homeName;
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${hotStorageDir}/${targetName}";
      };
    })
    userDirs;
}
