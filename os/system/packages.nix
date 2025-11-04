{ config, pkgs, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
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
    pinentry
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
    android-udev-rules
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
    python312
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
  services.logind.extraConfig = ''
    RuntimeDirectorySize=20G
  '';
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=yes
  '';
}
