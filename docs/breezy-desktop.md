# Breezy Desktop / XR Glasses (Viture)

Head-tracking support for XR glasses (Viture Luma Ultra here) via
[wheaney/XRLinuxDriver](https://github.com/wheaney/XRLinuxDriver), packaged as a
NixOS module in the local flake `/home/master/src/breezy-desktop-nix`.

## How it is wired

- `/home/master/src/breezy-desktop-nix` — local flake providing:
  - `packages.xrlinuxdriver` (the xrDriver daemon + CLI + udev rules)
  - `packages.breezy-gnome`, `packages.breezy-desktop-ui`, `breezy-desktop` (meta)
  - `nixosModules.default` (`services.breezy-desktop`)
- This flake imports it as a `path:` input pinned in `os/flake.lock` under
  the key `xrlinuxdriver`, and applies the module via `breezyModule`:

```nix
# os/flake.nix
 (breezyModule { gnome = true; })   # in the `gnome` host
```

The module enables the `xr-driver` user service, udev rules (`services.udev.packages`),
`uinput` kernel module and (with `gnome = true`) the GNOME session integration.

## Deploying

```bash
cd ~/src/breezy-desktop-nix   # make package changes here
nix build .#xrlinuxdriver     # quick sanity build

# 1. bump the path-pin of the module flake (must run as master, NOT root)
cd ~/src/nix
nix flake update --flake ./os xrlinuxdriver

# 2. rebuild
sudo nixos-rebuild --flake ./os#gnome switch --impure
```

## Gotchas

- **`sudo nixos-rebuild --flake ./os#gnome switch --impure` may fail with
  "repository path is not owned by current user"** — that's the `path:` input
  (a plain in-repo directory) being hashed by libgit2 as root. Fix:
  run the `nix flake update` / `nix build` steps as `master` first, then the
  switch. Worst case build the toplevel as master and switch as root:
  ```bash
  nix build ~/src/nix/os#nixosConfigurations.gnome.config.system.build.toplevel \
      --impure -o /tmp/system
  # as root:
  nix-env -p /nix/var/nix/profiles/system --set /tmp/opencode/system
  /tmp/opencode/system/bin/switch-to-configuration switch
  ```
- **Stale user unit**: `~/.config/systemd/user/xr-driver.service` may contain an
  old store-path symlink that shadows the new unit from `/etc/systemd/user/`.
  If the service fails right after an update with an old
  `xrlinuxdriver-<version>` path in `ExecStart`:
  ```bash
  rm ~/.config/systemd/user/xr-driver.service
  systemctl --user daemon-reload && systemctl --user restart xr-driver
  ```
- Transient `[ERROR] Segmentation fault` lines in
  `~/.local/state/xr_driver/driver.log` coming from `libcarina_vio.so` /
  `libglasses.so` are a known Viture SDK quirk and usually harmless.

## Upgrading the driver

1. Update `rev`/`version` in `~/src/breezy-desktop-nix/package.nix`
   (check upstream `CMakeLists.txt` for moved submodules/cargo roots —
   upstream restructures between versions).
2. Replace the `hash` with the hash Nix prints on the first build failure.
3. `cargoRoot` may need updating (as of 2.11.9:
   `modules/xrealOneDeviceKit/modules/xreal_one_driver`).
4. Deploy as above.
