{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  services.printing.enable = true;

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
    vim
    gcc
    unzip
    wget
    plasma5Packages.bismuth
    kdeconnect
    firefox
    thunderbird
    remmina
    docker-buildx
  ];
}
