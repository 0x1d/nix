{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "ch";
    xkb.variant = "";
  };
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.cosmic.enable = true;
}
