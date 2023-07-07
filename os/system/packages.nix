{ pkgs, ... }: {
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
