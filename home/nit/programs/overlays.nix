{inputs}: final: prev: {
  sorter = final.callPackage ./utilities/sorter.nix {};
  recorder = final.callPackage ./media/recorder.nix {};
  pawncc = final.callPackage ./developing/pawncc.nix {};
  assets = final.callPackage ./assets.nix {};
  manhattan-cafe = final.callPackage ./desktop-environment/manhattan-cafe.nix {};
  lutris =
    (import inputs.lutris-nixpkgs {
      inherit (prev) system;
      config.allowUnfree = true;
    }).lutris;
}
