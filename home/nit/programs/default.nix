{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.oxicord.packages.${system}.default
    inputs.elyprismlauncher.packages.${system}.default
  ];

  imports = [
    ./communication/default.nix
    ./desktop-environment/default.nix
    ./developing/default.nix
    ./utilities/default.nix
    ./gaming/default.nix
    ./media/default.nix
    ./office/default.nix
    ./terminal/default.nix
  ];
}
