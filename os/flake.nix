{
  description = "flake for nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # XRLinuxDriver from https://github.com/wheaney/XRLinuxDriver/pull/80
    xrlinuxdriver.url = "path:/home/master/src/breezy-desktop-nix";
    xrlinuxdriver.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, xrlinuxdriver }:
  let
    breezyPkgs = system: xrlinuxdriver.packages.${system};
    breezyModule = { gnome ? false }:
      { pkgs, ... }:
      let
        bp = breezyPkgs pkgs.system;
      in {
        imports = [ xrlinuxdriver.nixosModules.default ];
        services.breezy-desktop = {
          enable = true;
          xrlinuxdriver = bp.xrlinuxdriver;
          breezy-gnome = bp.breezy-gnome;
          breezy-desktop-ui = bp.breezy-desktop-ui;
          gnome.enable = gnome;
        };
      };
  in {
    nixosConfigurations = {
      gnome = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hardware/lenovo-thinkpad-e14.nix
          ./system/base.nix
          ./system/packages.nix
          ./system/desktop/gnome.nix
          ./users/demo.nix
          ./users/master.nix
          (breezyModule { gnome = true; })
        ];
        specialArgs = { inherit nixpkgs-unstable; };
      };
      kde = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hardware/lenovo-thinkpad-e14.nix
          ./system/base.nix
          ./system/packages.nix
          ./system/desktop/plasma.nix
          ./users/demo.nix
          ./users/master.nix
          (breezyModule { })
        ];
        specialArgs = { inherit nixpkgs-unstable; };
      };
      hyprland = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hardware/lenovo-thinkpad-e14.nix
          ./system/base.nix
          ./system/packages.nix
          ./system/desktop/hyprland.nix
          ./users/demo.nix
          ./users/master.nix
          (breezyModule { })
        ];
        specialArgs = { inherit nixpkgs-unstable; };
      };
    };
  };
}
