{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = "ch";
    xkbVariant = "";
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
