{inputs, ...}: final: prev: let
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit (prev) system;
    config = builtins.removeAttrs prev.config ["rewriteURL"];
  };
in {
  sorter = final.callPackage ./utilities/sorter.nix {};
  recorder = final.callPackage ./media/recorder.nix {};
  assets = final.callPackage ./assets.nix {};
  manhattan-cafe = final.callPackage ./desktop-environment/manhattan-cafe.nix {};

  lutris = pkgs-stable.lutris;
}
