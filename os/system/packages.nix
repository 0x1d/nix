{ config, pkgs, nixpkgs-unstable, claude-desktop, opencode-desktop, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = config.nixpkgs.config;
  };
  # The packaging flake's auto-update stalled at 2.9939.4 (Sep 2026); pull the
  # current .deb from Anthropic's apt repo directly. Drop once upstream catches up.
  claudeDesktop = (claude-desktop.packages.${pkgs.system}.default).overrideAttrs (old: rec {
    version = "4.23118.1";
    src = pkgs.fetchurl {
      url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_${version}_amd64.deb";
      hash = "sha256-sJzN1ys4kWyWN9SFSNtw53xCXrLgm7RnRlQJ0v+dKHo=";
    };
    # 4.x's claude-native binding links against libpipewire.
    buildInputs = old.buildInputs ++ [ pkgs.pipewire ];
  });

  # The packaging repo still pins desktop 1.19.5, whose bundled backend only
  # understands the pre-v2 database schema. The installed CLI (2.2.x) already
  # uses the v2 schema, so 1.19.5 fails with
  # "Database is not empty and has no session table".
  # Use the matching 2.2.6 desktop release instead.
  opencodeDesktop = (opencode-desktop.packages.${pkgs.system}.default).overrideAttrs (old: {
    version = "2.2.6";
    src = pkgs.fetchurl {
      url = "https://github.com/anomalyco/opencode/releases/download/v2.2.6/opencode-desktop-linux-amd64.deb";
      hash = "sha256-h/ZlVfOj/sOQHvfhrIb14t61W5AATPQjludUfGsZVFk=";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/opencode-desktop $out/bin $out/share
      cp -r opt/OpenCode/* $out/lib/opencode-desktop/

      # autoPatchelf corrupts the Bun standalone binary that ships as the v2
      # sidecar. Keep an unmodified copy and restore it after fixup.
      cp opt/OpenCode/resources/opencode-cli "$TMPDIR/opencode-cli.orig"

      install -Dm644 usr/share/applications/ai.opencode.desktop.desktop \
        $out/share/applications/opencode-desktop.desktop
      substituteInPlace $out/share/applications/opencode-desktop.desktop \
        --replace-fail 'Exec=/opt/OpenCode/ai.opencode %U' "Exec=$out/bin/opencode-desktop %U"

      if [ -d usr/share/icons ]; then
        cp -r usr/share/icons $out/share/
      fi

      makeWrapper $out/lib/opencode-desktop/ai.opencode $out/bin/opencode-desktop \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath old.buildInputs}" \
        --set-default OC_ALLOW_WAYLAND 1

      cat > $out/bin/opencode-cli << 'EOF'
      #!/usr/bin/env bash
      # Wrapper for opencode CLI - searches PATH and ~/.opencode/bin
      if command -v opencode &>/dev/null; then
        exec opencode "$@"
      elif [ -x "$HOME/.opencode/bin/opencode" ]; then
        exec "$HOME/.opencode/bin/opencode" "$@"
      else
        echo "Error: opencode CLI not found. Install via: curl -fsSL https://opencode.ai/install | bash" >&2
        exit 1
      fi
      EOF
      chmod +x $out/bin/opencode-cli

      runHook postInstall
    '';

    postFixup = ''
      cp "$TMPDIR/opencode-cli.orig" $out/lib/opencode-desktop/resources/opencode-cli
      chmod +x $out/lib/opencode-desktop/resources/opencode-cli
    '';
  });
in {

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-24.8.6"
      "electron-25.9.0"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  services.printing.enable = true;
  services.blueman.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  environment.systemPackages = with pkgs; [
    fd
    fzf
    ripgrep
    jq
    git
    git-lfs
    gh
    ranger
    highlight
    gnumake
    pinentry-gnome3
    direnv
    dnsutils
    netcat
    vim
    gcc
    unzip
    wget
    firefox
    thunderbird
    remmina
    docker-buildx
    appimage-run
    gimp
    libation
    ledger-live-desktop
    ledger-udev-rules
    android-tools
    ghostty
    alacritty
    brave
    #unstable.gsconnect
    unstable.code-cursor
    go
    gnomeExtensions.forge
    platformio
    avrdude
    #python314
    # Wrap so buildEnv does not pick up python312's broken passthru.doc (uncached on 26.05)
    (symlinkJoin {
      name = python312.name;
      paths = [ python312 ];
    })
    esptool
    wireguard-tools
    protonvpn-gui
    uv
    portaudio
    python312Packages.pyaudio
    hwinfo
    usbutils
    unstable.cursor-cli
    ffmpeg
    unstable.golangci-lint
    unstable.terraform
    unstable.opencode
    unstable.claude-code
    unstable.zed-editor
    claudeDesktop
    opencodeDesktop
    libsecret
    qemu
    OVMFFull
    virtiofsd
  ];

  fonts.packages = with pkgs; [ 
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono 
  ];

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    uv
    portaudio
  ];
  # for protonvpn
  networking.firewall.checkReversePath = false;
  
  services.udev.packages = [ 
    pkgs.platformio-core
    pkgs.platformio-core.udev
    pkgs.openocd
  ];
  services.logind.settings = {
    Login = {
      RuntimeDirectorySize = "20G";
    };
  };
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "yes";
    AllowHibernation = "yes";
    AllowHybridSleep = "yes";
    AllowSuspendThenHibernate = "yes";
  };
}
