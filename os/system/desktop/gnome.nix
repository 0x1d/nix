{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = "ch";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
