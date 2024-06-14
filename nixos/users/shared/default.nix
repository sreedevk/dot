{ pkgs, secrets, username, ... }: {
  imports =
    [ ./zsh.nix ./ssh.nix ./taskwarrior.nix ./systemd.nix ./packages.nix ];

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

    ".tmux.conf" = {
      enable = true;
      source = ../../../stowed/.tmux.conf;
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

  programs.home-manager.enable = true;
  programs.htop.enable = true;

  news.display = "silent";

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      frequency = "weekly";
    };
    settings = {
      show-trace = true;
      auto-optimise-store = true;
      fallback = true;
      experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
    };
  };
}
