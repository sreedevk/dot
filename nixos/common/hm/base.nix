{
  username,
  opts,
  ...
}:
{
  home = {
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
    username = "${username}";
  };

  age = {
    identityPaths = [
      "/home/${username}/.ssh/id_rsa"
      "/home/${username}/.ssh/id_ed25519"
      "/home/${username}/.ssh/devtechnica"
    ];
    secretsDir = "/home/${username}/.agenix/agenix";
    secretsMountPoint = "/home/${username}/.agenix/agenix.d";
  };

  home.file = {
    ".config" = {
      enable = true;
      source = ../../../stowed/.config;
      recursive = true;
    };

    ".bashrc" = {
      enable = true;
      source = ../../../stowed/.bashrc;
      recursive = true;
    };

    ".bash_profile" = {
      enable = true;
      executable = true;
      recursive = true;
      text = ''
        [[ -f ~/.profile ]]  && . ~/.profile
        [[ -f ~/.bashrc  ]]  && . ~/.bashrc
        [[ -f ~/.zshenv  ]]  && . ~/.zshenv
      '';
    };

    ".xsession" = {
      enable = true;
      executable = true;
      recursive = true;
      text = ''
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
        export GDK_SCALE=${opts.desktop.scale}
        export GDK_DPI_SCALE=${opts.desktop.scale}
        export QT_AUTO_SCREEN_SCALE_FACTOR=${opts.desktop.scale}
        export QT_SCALE_FACTOR=${opts.desktop.scale}
        export WINIT_X11_SCALE_FACTOR=${opts.desktop.scale}
      '';
    };
  };

  programs = {
    home-manager.enable = true;
  };

  systemd.user = {
    enable = true;
    startServices = "sd-switch";
  };

  news.display = "silent";
}
