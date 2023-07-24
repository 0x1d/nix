{ pkgs, ... }: {
  imports = [
    ./boot.nix
    ./security.nix
    ./i18n.nix
    ./network.nix
    ./sound.nix
    ./xserver.nix
    ./virtualisation.nix
    ./packages.nix
  ];
}
