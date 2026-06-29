{
  inputs = {
    nixpkgs.url          = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url   = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, disko, sops-nix, ... }:
  let
    system = "x86_64-linux";

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    # The hostname is the hosts/ dir name.
    mkHost = hostname: { hardware ? [], withHome ? false, withDisko ? false }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs-unstable hostname; };
        modules = [
          ./hosts/${hostname}
          sops-nix.nixosModules.sops
        ]
        ++ hardware
        ++ (if withDisko then [
          disko.nixosModules.disko
          ./hosts/${hostname}/disko.nix
        ] else [])
        ++ (if withHome then [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs       = true;
            home-manager.useUserPackages     = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs    = { inherit pkgs-unstable; };
            home-manager.users.miguel        = import ./modules/home;
          }
        ] else []);
      };

  in {
    nixosConfigurations = {

      orca = mkHost "orca" {
        hardware = [ nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen1 ];
        withHome = true;
      };

      angler = mkHost "angler" {
        withDisko = true;
      };

    };
  };
}
