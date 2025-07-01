{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball {
      url = "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
      sha256 = "sha256:19wkjfhyidvkp4wjrr7idx83iiql6bskp1x1wrp52y0lc3xx847y";
    })
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{

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
    code-cursor
    go
    gnomeExtensions.forge
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
