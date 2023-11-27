{ pkgs, ... }: {
  virtualisation = {
    docker.enable = true;
    # following configuration is added only when building VM with build-vm
    vmVariant = {
      virtualisation = {
        memorySize = 2048;
        cores = 2;
      };
    };
  };
}
