#!/usr/bin/env bash

##
##Usage: ctl.sh <command> <subcommand>
##
## ~> os
##
##    test              Rebuild and test OS without new generation
##    rebuild           Rebuild OS and create new generation
##    channel           Set release channel
##    upgrade           Upgrade channels and rebuild OS
##    changes           Show changes between generations
##    gc                Garbage collect old generations
##    vm                Build and run as VM
##
## ~> vm
##
##    build             Build virtual machine
##    run               Run virtual machine
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

RED="31"
GREEN="32"
GREENBLD="\e[1;${GREEN}m"
REDBOLD="\e[1;${RED}m"
REDITALIC="\e[3;${RED}m"
EC="\e[0m"

function info {
	clear
	cat motd
	echo "NixOS Version $(nixos-version)"
	sed -n 's/^##//p' ctl.sh
}

function os {
	function test {
		sudo nixos-rebuild --flake ./os#${1} test
	}
	function rebuild {
		echo "Rebuild OS config: ${1}"
		sudo nixos-rebuild --flake ./os#${1} switch
	}
	function upgrade {
		echo "Upgrade channels and rebuild ${1}"
		sudo nix-channel --update
		sudo nixos-rebuild --upgrade --flake ./os#${1} switch
	}
	function channel {
		sudo nix-channel --list
		if [ -n "${1}" ]; then
			echo "Set channel to ${1}"
			sudo nix-channel --remove nixos
			sudo nix-channel --add https://nixos.org/channels/nixos-${1} nixos
		fi
	}
	function changes {
		nix profile diff-closures --profile /nix/var/nix/profiles/system
	}
	function gc {
		sudo nix-collect-garbage -d
		sudo nixos-rebuild switch
	}
	${@}
}

function vm {
	function build {
		echo "Build configuration ${1} as VM"
		#rm *.qcow2
		nixos-rebuild build-vm --flake ./os#${1}
	}
	function run {
		result/bin/run-*-vm
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

function repl {
	info
	echo -e "\n${REDBOLD}Enter command...${EC}"
	read -p '~> '
	clear
	./ctl.sh ${REPLY}
	read -p "Press any key to continue."
	repl
}

${@:-info}
