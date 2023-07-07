#!/usr/bin/env bash

##
## ~> OS
##

function info {
	clear
	cat motd
	echo "NixOS Version $(nixos-version)"
	sed -n 's/^##//p' ctl.sh
}

##    os-test           Rebuild and test OS without creating a new generation
function os-test {
	sudo nixos-rebuild --flake ./os#nixos test
}

##    os-rebuild        Rebuild OS and create new generation
function os-rebuild {
	echo "Rebuild OS"
	sudo nixos-rebuild --flake ./os#nixos switch
}

##    os-upgrade        Upgrade channels and rebuild OS
function os-upgrade {
	echo "Upgrade channels and rebuild OS"
	sudo nixos-rebuild --upgrade --flake ./os#nixos switch
}

##    vm                Build and run as VM
function vm {
	echo "Build and run configuration as VM"
	rm *.qcow2
	nixos-rebuild build-vm --flake ./os#nixos && result/bin/run-*-vm
}

##
## ~> Store
##

##    store-gc          Collecting garbage in nix-store
function store-gc {
	echo "Collecting garbage"
	nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"
}

##    store-optimise    Optimise nix-store
function store-optimise {
	echo "Optimizing nix-store. This may take a moment..."
	nix-store --optimise
}

##    search PACKAGE    Search for package
function search {
	nix search nixpkgs $1
}

##
## ~> Shell
##

##    shell NAME        Run a nix-shell from ./shell/
function shell {
	nix-shell ./shell/$1.nix
}

${@:-info}
