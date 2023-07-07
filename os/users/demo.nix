{ pkgs, ... }: {
  users.users.demo.isNormalUser = true;
  users.users.demo.initialPassword = "demo";
  system.stateVersion = "23.05";
}
