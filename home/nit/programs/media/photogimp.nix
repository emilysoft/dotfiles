{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.mis-modulos.media.photogimp;
  gimpConfigDir = ".config/GIMP/${lib.versions.majorMinor pkgs.gimp.version}";
  photogimpConfig = "${inputs.photogimp}/.config/GIMP/3.0";

  collectFiles = dir: rel:
    builtins.foldl' (
      acc: name:
        if (builtins.readDir dir).${name} == "directory"
        then acc // (collectFiles "${dir}/${name}" "${rel}/${name}")
        else
          acc
          // {
            "${rel}/${name}" = {
              source = "${dir}/${name}";
              force = true;
            };
          }
    ) {} (builtins.attrNames (builtins.readDir dir));

  photogimpFiles =
    lib.filterAttrs (name: _: name != "${gimpConfigDir}/theme.css")
    (collectFiles photogimpConfig gimpConfigDir);
in {
  options.mis-modulos.media.photogimp = {
    enable = lib.mkEnableOption "PhotoGIMP, a Photoshop-like configuration for GIMP";
  };

  config = lib.mkIf cfg.enable {
    home.file = photogimpFiles;
  };
}
