{ pkgs, ... }: {
  imports = [
    ./hyprland-config.nix
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "ch";
    xkb.variant = "";
  };

  # Hyprland configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable wayland support
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Additional packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Waybar for status bar
    waybar
    # Notification daemon
    dunst
    # Screenshot tool
    grim
    slurp
    # Color picker
    hyprpicker
    # Wallpaper utility
    swww
    # Clipboard manager
    wl-clipboard
    # Terminal
    alacritty
    # Application launcher
    wofi
    # File manager
    xfce.thunar
    # Volume control
    pavucontrol
    # Clipboard history
    cliphist
    # Brightness control
    brightnessctl
    # Power management
    power-profiles-daemon
  ];
} 