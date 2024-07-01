{ pkgs, username, ... }: {
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

    ".gitattributes" = {
      enable = true;
      source = ../../../stowed/.gitattributes;
      recursive = true;
    };

    ".gitconfig" = {
      enable = true;
      source = ../../../stowed/.gitconfig;
      recursive = true;
    };

    ".gitignore" = {
      enable = true;
      source = ../../../stowed/.gitignore;
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
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;
    zsh.enable = true;
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
    trusted-users = ["${username}"];
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      show-trace = true;
      auto-optimise-store = true;
      fallback = true;
      experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
    };
  };
}
