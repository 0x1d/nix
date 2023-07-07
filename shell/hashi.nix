let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    dnsutils
    netcat
    ansible
    terraform
    consul
    unstable.nomad_1_5
    vault
    nomad-pack
    waypoint
  ];
}
