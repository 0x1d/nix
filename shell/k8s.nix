let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
  }
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    dnsutils
    netcat
    terraform
    kubectl
    kubernetes-helm
    k9s
    lens
  ];
}
