{ pkgs, age, nixpkgs, username, opts, ... }: {

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

    ".tool-versions" = {
      enable = true;
      recursive = true;
      text =
        let

          versions = [
            { tool = "bun"; version = "1.1.42"; }
            { tool = "deno"; version = "2.1.4"; }
            { tool = "elixir"; version = "1.18.0-otp-27"; }
            { tool = "erlang"; version = "27.2"; }
            { tool = "gleam"; version = "1.6.3"; }
            { tool = "golang"; version = "1.23.4"; }
            { tool = "nim"; version = "2.2.0"; }
            { tool = "opam"; version = "2.3.0"; }
            { tool = "ruby"; version = "3.3.6"; }
            { tool = "zig"; version = "0.13.0"; }
          ];
        in
        builtins.concatStringsSep "\n" (builtins.map (v: "${v.tool} ${v.version}") versions);
    };

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

    ".xinitrc" = {
      enable = true;
      executable = true;
      target = ".xinitrc";
      text = ''
        . ~/.profile
        . ~/.xsession

        xrdb ~/.Xresources

        exec i3
      '';
    };

    ".profile" = {
      enable = true;
      recursive = false;
      target = ".profile";
      executable = true;
      text = ''
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
      '';
    };


    ".xsession" = {
      enable = true;
      executable = true;
      recursive = true;
      text = ''
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
        export GDK_SCALE=1.1
        export GDK_DPI_SCALE=1.1
        export QT_AUTO_SCREEN_SCALE_FACTOR=1.1
        export QT_SCALE_FACTOR=1.1
        export WINIT_X11_SCALE_FACTOR=1.1
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
        x-scheme-handler/http=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/https=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/about=${opts.default-web-browser.xdg-desktop}
        x-scheme-handler/unknown=${opts.default-web-browser.xdg-desktop}
        image/png=nsxiv.desktop
        image/jpeg=nsxiv.desktop
        image/gif=nsxiv.desktop
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
    package = pkgs.nixVersions.nix_2_25;
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "${username}" ];
      allowed-users = [ "${username}" ];
      trusted-substituters = [ "${username}" ];
      show-trace = true;
      auto-optimise-store = true;
      fallback = true;
      experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
    };
  };
}
