{ pkgs, ... }: {
  networking = {
    hostName = "nixos";
    #nameservers = [ "192.168.1.1" "10.0.0.1" "10.0.1.1" "9.9.9.9" "2620:fe::fe" ];
    #nameservers = [ "127.0.0.1" ];
    networkmanager = {
      enable = true;
      #dns = "none";
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
  # services.dnsmasq = {
  #   enable = true;
  #   resolveLocalQueries = true;
  #   servers = [
  #     ''/.mesh.dcentral.systems/10.101.0.7''
  #     ''9.9.9.9''
  #     ''8.8.8.8''
  #   ];
  # };
}
