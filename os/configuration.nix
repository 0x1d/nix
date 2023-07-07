{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  system.stateVersion = "23.05";

  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #  networking.hostName = "nixos";
  #  networking.networkmanager.enable = true;

  #  time.timeZone = "Europe/Zurich";
  #  i18n.defaultLocale = "en_US.UTF-8";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # xserver
  # services.xserver = {
  #   enable = true;
  #   layout = "ch";
  #   xkbVariant = "";
  #   # Enable the KDE Plasma Desktop Environment.
  #   displayManager.sddm.enable = true;
  #   desktopManager.plasma5.enable = true;
  # };
  # Configure console keymap
  #console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  #  users.users.master = {
  #    isNormalUser = true;
  #    description = "master";
  #    extraGroups = [ "networkmanager" "wheel" ];
  #    packages = with pkgs; [
  #      kate
  #    ];
  #  };

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #  environment.systemPackages = with pkgs; [
  #    fd
  #    fzf
  #    ripgrep
  #    jq
  #    git
  #    pinentry
  #    vim
  #    gcc
  #    unzip
  #    wget
  #    plasma5Packages.bismuth
  #    kdeconnect
  #    firefox
  #    thunderbird
  #    remmina
  #  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPortRanges = [
  #     { from = 1714; to = 1764; } # KDE Connect
  #   ];
  #   allowedUDPPortRanges = [
  #     { from = 1714; to = 1764; } # KDE Connect
  #   ];
  # };

}
