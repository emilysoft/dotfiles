{
  description = "Nit's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elyprismlauncher = {
      url = "github:ElyPrismLauncher/ElyPrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oxicord = {
      url = "github:linuxmobile/oxicord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    shared-overlays = [
      inputs.niri.overlays.niri
      inputs.nix-cachyos-kernel.overlays.pinned
      (import ./home/nit/programs/overlays.nix)
    ];
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/desktop/configuration.nix
          {
            #FIXME Due to a CVE-2024-27297 vulnerability, this has been temporarily placed.
            nix.package = inputs.nixpkgs-unstable.legacyPackages.${system}.nix;
            nixpkgs = {
              overlays = shared-overlays;
              config = {
                allowUnfree = true;
                joypixels.acceptLicense = true;
                allowUnfreePredicate = pkg:
                  builtins.elem (nixpkgs.lib.getName pkg) [
                    "joypixels"
                  ];
              };
            };

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.nit = {
                imports = [
                  ./home/nit/home.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
