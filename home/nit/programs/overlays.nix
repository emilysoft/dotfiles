final: prev: {
  #systemd = prev.systemd.overrideAttrs (old: {
  #  src = final.fetchFromGitHub {
  #    owner = "systemd";
  #    repo = "systemd";
  #    rev = "258";
  #    hash = "sha256-xtGZaVNsBNxkidgfVBu8xtvj0SxpY6OyJCUE+gq59qE=";
  #  };
  #});
  discord-desktop-mobile = final.callPackage ./communication/discord-desktop-mobile.nix { };
  sorter = final.callPackage ./utilities/sorter.nix { };
  recorder = final.callPackage ./media/recorder.nix { };
  pawncc = final.callPackage ./developing/pawncc.nix { };
  ferdium = final.callPackage ./communication/ferdium.nix { };
  assets = final.callPackage ./assets.nix { };
  manhattan-cafe = final.callPackage ./desktop-environment/manhattan-cafe.nix { };
}
