{ pkgs, nixpkgs, username, opts, ... }: {

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  home.file = {

    ".tool-versions" = {
      enable = true;
      recursive = true;
      text =
        let
          versions = [
            { tool = "bun"; version = "1.1.20"; }
            { tool = "elixir"; version = "1.17.2-otp-27"; }
            { tool = "erlang"; version = "27.0.1"; }
            { tool = "golang"; version = "1.22.5"; }
            { tool = "nodejs"; version = "22.5.1"; }
            { tool = "ruby"; version = "3.2.1"; }
            { tool = "zig"; version = "0.13.0"; }
            { tool = "gleam"; version = "1.3.2"; }
            { tool = "sbcl"; version = "2.4.5"; }
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
        export GDK_SCALE=1.2
        export GDK_DPI_SCALE=1.2
        export QT_AUTO_SCREEN_SCALE_FACTOR=1.2
        export QT_SCALE_FACTOR=1.2
        export WINIT_X11_SCALE_FACTOR=1.2
      '';
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
      trusted-substituters = [ "${username}" ];
      show-trace = true;
      auto-optimise-store = true;
      fallback = true;
      experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
    };
  };
}
