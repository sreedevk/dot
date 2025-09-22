{
  pkgs,
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

    "mimeapps.list" = {
      enable = true;
      recursive = false;
      executable = false;
      target = ".config/mimeapps.list";
      text = ''
        [Default Applications]
        text/plain=neovim.desktop
        text/html=neovim.desktop
        text/unknown=neovim.desktop
        inode/directory=nemo.desktop
        x-scheme-handler/http=${opts.desktop.browser.xdg-desktop or ""}
        x-scheme-handler/https=${opts.desktop.browser.xdg-desktop or ""}
        x-scheme-handler/about=${opts.desktop.browser.xdg-desktop or ""}
        x-scheme-handler/unknown=${opts.desktop.browser.xdg-desktop or ""}
        image/png=nsxiv.desktop
        image/jpeg=nsxiv.desktop
        image/gif=nsxiv.desktop

        [Added Associations]
        application/atom+xml=${opts.desktop.browser.xdg-desktop or ""};
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowBroken = true;
    };
  };

  nix = {
    package = pkgs.nixVersions.nix_2_28;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "${username}" ];
      http2 = false;
      allowed-users = [ "${username}" ];
      trusted-substituters = [ "${username}" ];
      show-trace = true;
      auto-optimise-store = true;
      fallback = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];
    };
  };
}
