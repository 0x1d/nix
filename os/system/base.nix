{ pkgs, ... }: {
  imports = [
    ./boot.nix
    ./security.nix
    ./i18n.nix
    ./network.nix
    ./sound.nix
    ./virtualisation.nix
  ];
}
