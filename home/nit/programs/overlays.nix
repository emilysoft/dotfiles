final: prev: {
  discord-desktop-mobile = final.callPackage ./communication/discord-desktop-mobile.nix {};
  sorter = final.callPackage ./utilities/sorter.nix {};
  recorder = final.callPackage ./media/recorder.nix {};
  pawncc = final.callPackage ./developing/pawncc.nix {};
  assets = final.callPackage ./assets.nix {};
  manhattan-cafe = final.callPackage ./desktop-environment/manhattan-cafe.nix {};
}
