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
          ./system/i18n.nix
          ./system/network.nix
          ./system/sound.nix
          ./system/xserver.nix
          ./system/virtualisation.nix
          ./system/packages.nix
          ./users/demo.nix
          ./users/master.nix
        ];
      };
    };
  };
}
