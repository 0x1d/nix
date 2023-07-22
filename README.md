# Nix Configuration

This repo contains my personal Nix / NixOS configuration.

## Usage

Run `ctl.sh` to see the list of commands to manage the system.

```bash
./ctl.sh

Usage: ctl.sh <command> <subcommand>

 ~> os

    test              Rebuild and test OS without new generation
    rebuild           Rebuild OS and create new generation
    upgrade           Upgrade channels and rebuild OS
    changes           Show changes between generations
    gc                Garbage collect old generations
    vm                Build and run as VM

 ~> store

    gc                Collecting garbage in nix-store
    optimise          Optimise nix-store
    search PACKAGE    Search for package

 ~> shell

    run NAME          Run a nix-shell from ./shell/
```
