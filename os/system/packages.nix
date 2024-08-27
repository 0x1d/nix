{ pkgs, ... }: {

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-24.8.6"
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
