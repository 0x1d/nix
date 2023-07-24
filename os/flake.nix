{
  description = "flake for nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hw/lenovo-thinkpad-e14.nix
          ./system/base.nix
          ./users/demo.nix
          ./users/master.nix
        ];
      };
      testos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hw/lenovo-thinkpad-e14.nix
          ./system/base.nix
          ./users/demo.nix
          ./users/master.nix
        ];
      };
    };
  };
}
