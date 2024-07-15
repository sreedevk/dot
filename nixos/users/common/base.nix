{ pkgs, username, opts, ... }: {
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  home.file = {

    ".tool-versions" = {
      enable = true;
      source = ../../../stowed/.tool-versions;
      recursive = true;
    };

    ".config" = {
      enable = true;
      source = ../../../stowed/.config;
      recursive = true;
    };

    ".local" = {
      enable = true;
      source = ../../../stowed/.local;
      recursive = true;
    };

    ".bashrc" = {
      enable = true;
      source = ../../../stowed/.bashrc;
      recursive = true;
    };

    ".profile" = {
      enable = true;
      source = ../../../stowed/.profile;
      recursive = true;
    };

    ".vimrc" = {
      enable = true;
      source = ../../../stowed/.vimrc;
      recursive = true;
    };

    ".xsession" = {
      enable = true;
      executable = true;
      source = ../../../stowed/.xsession;
      recursive = true;
    };

    "mimeapps.list" = {
      enable = true;
      recursive = false;
      executable = false;
      target = ".config/mimeapps.list";
      text = ''
        [Default Applications]
        text/html=firefox.desktop
        x-scheme-handler/http=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/https=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/about=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/unknown=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/discord-1176718791388975124=${opts.default-web-browser.xdg-desktop}
      '';
    };
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;
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
    };
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "${username}" ];
      allowed-users = [ "${username}" ];
      show-trace = true;
      auto-optimise-store = true;
      fallback = true;
      experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
    };
  };
}
