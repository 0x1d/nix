{ config, pkgs, ... }:

{

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  system.stateVersion = "23.05";

}
