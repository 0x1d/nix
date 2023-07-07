# Nix Configuration

This repo contains my personal Nix / NixOS configuration.

## Usage

Run `ctl.sh` to see the list of commands to manage the system.

```bash
./ctl.sh

 ~> OS

    os-test           Rebuild and test OS without creating a new generation
    os-rebuild        Rebuild OS and create new generation
    os-upgrade        Upgrade channels and rebuild OS
    vm                Build and run as VM

 ~> Store

    store-gc          Collecting garbage in nix-store
    store-optimise    Optimise nix-store
    search PACKAGE    Search for package

 ~> Shell

    shell NAME        Run a nix-shell from ./shell/
```
