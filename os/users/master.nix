{ pkgs, ... }: {

  users.users.master = {
    isNormalUser = true;
    description = "master";
    initialPassword = "master";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "tty" "dialout" "audio"];
  };

  home-manager.users.master = {

    home.stateVersion = "23.05";
    home.username = "master";
    home.homeDirectory = "/home/master";
    home.sessionVariables = {
      EDITOR = "vim";
    };
    home.packages = with pkgs; [
      #plasma5Packages.bismuth
      #kdeconnect
      #kcalc
      #filelight
      ghostty
      gparted
      veracrypt
      #nerdfonts
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
      obsidian
      libreoffice-qt
      hunspell
      hunspellDicts.de_CH
      imagemagick
      #solana-cli
      sqlite
      rtl-sdr
      gopls
    ];

    programs = {
      home-manager.enable = true;
      bash = {
        enable = true;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
        settings = {
          directory.fish_style_pwd_dir_length = 1;
          directory.truncation_length = 2;
        };
      };
      #neovim = {
      #  enable = true;
      #  defaultEditor = true;
      #  viAlias = true;
      #  vimAlias = true;
      #  vimdiffAlias = true;
      #};
    };

    services = {
      syncthing = {
        enable = true;
      };
    };
  };
}
