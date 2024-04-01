let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    stdenv
    gnumake
    cmake
    python311Full
    python310Packages.nltk
    python310Packages.pip
    conda
    poetry
    ninja
    nodejs
  ];
  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
}
