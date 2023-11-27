{ pkgs, ... }: {
  users.users.demo.isNormalUser = true;
  users.users.demo.initialPassword = "demo";
  system.stateVersion = "23.05";

  home-manager.users.demo = {
    home.stateVersion = "23.05";
    home.username = "demo";
    home.homeDirectory = "/home/demo";
  };
}
