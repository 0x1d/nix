{ pkgs, ... }: {

  users.users.master = {
    isNormalUser = true;
    description = "master";
    initialPassword = "master";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.master = {

    home.stateVersion = "23.05";
    home.username = "master";
    home.homeDirectory = "/home/master";
    home.packages = with pkgs; [
      nerdfonts
      tmux
      btop
      ranger
      vscode
      nodejs
      terraform
      consul
      nomad
      packer
      cargo
      kubectl
      chromium
    ];

    programs.home-manager.enable = true;

    programs.bash = {
      enable = true;
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        directory.fish_style_pwd_dir_length = 1;
        directory.truncation_length = 2;
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
