{ config, pkgs, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = config.nixpkgs.config;
  };
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
