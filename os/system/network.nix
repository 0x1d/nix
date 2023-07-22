{ pkgs, ... }: {
  networking = {
    hostName = "nixos";
    nameservers = [ "192.168.1.1" "9.9.9.9" "2620:fe::fe" ];
    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
}
