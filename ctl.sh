#!/usr/bin/env bash

##
##Usage: ctl.sh <command> <subcommand>
##
## ~> os
##
##    test              Rebuild and test OS without new generation
##    rebuild           Rebuild OS and create new generation
##    upgrade           Upgrade channels and rebuild OS
##    changes           Show changes between generations
##    gc                Garbage collect old generations
##    vm                Build and run as VM
##
## ~> store
##
##    gc                Collecting garbage in nix-store
##    optimise          Optimise nix-store
##    search PACKAGE    Search for package
##
## ~> shell
##
##    run NAME          Run a nix-shell from ./shell/

function info {
	clear
	cat motd
	echo "NixOS Version $(nixos-version)"
	sed -n 's/^##//p' ctl.sh
}

function os {
	function test {
		sudo nixos-rebuild --flake ./os#nixos test
	}
	function rebuild {
		echo "Rebuild OS config: ${1}"
		sudo nixos-rebuild --flake ./os#${1} switch
	}
	function upgrade {
		echo "Upgrade channels and rebuild OS"
		sudo nixos-rebuild --upgrade --flake ./os#nixos switch
	}
	function changes {
		nix profile diff-closures --profile /nix/var/nix/profiles/system
	}
	function gc {
		sudo nix-collect-garbage -d
		sudo nixos-rebuild switch
	}
	function vm {
		echo "Build and run configuration as VM"
		rm *.qcow2
		nixos-rebuild build-vm --flake ./os#nixos && result/bin/run-*-vm
	}
	${@}
}

function store {
	function gc {
		echo "Collecting garbage"
		nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"
	}
	function optimise {
		echo "Optimizing nix-store. This may take a moment..."
		nix-store --optimise
	}
	function search {
		nix search nixpkgs $1
	}
	${@}
}

function shell {
	function run {
		nix-shell ./shell/$1.nix
	}
	${@}
}

${@:-info}
