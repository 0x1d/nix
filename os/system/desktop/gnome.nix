{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "ch";
    xkb.variant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
