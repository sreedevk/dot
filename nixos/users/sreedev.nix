{ configs, pkgs, secrets, ... }:
{
  home = {
    username = "sreedev";
    homeDirectory = "/home/sreedev";
    stateVersion = "23.11";
  };
  home.file = {
    ".tool-versions" = {
      enable = true;
      source = ../../stowed/.tool-versions;
      recursive = true;
    };
    ".zshrc" = {
      enable = true;
      executable = false;
      recursive = false;
      source = ../../stowed/.zshrc;
    };
    ".zsh" = {
      enable = true;
      source = ../../stowed/.zsh;
      recursive = true;
    };
    ".config" = {
      enable = true;
      source = ../../stowed/.config;
      recursive = true;
    };
    ".local" = {
      enable = true;
      source = ../../stowed/.local;
      recursive = true;
    };
    ".bashrc" = {
      enable = true;
      source = ../../stowed/.bashrc;
      recursive = true;
    };
    ".gitattributes" = {
      enable = true;
      source = ../../stowed/.gitattributes;
      recursive = true;
    };
    ".gitconfig" = {
      enable = true;
      source = ../../stowed/.gitconfig;
      recursive = true;
    };
    ".gitignore" = {
      enable = true;
      source = ../../stowed/.gitignore;
      recursive = true;
    };
    ".taskrc" = {
      enable = true;
      text = ''
        include dark-violets-256.theme
        data.location=~/.task/
        hooks.location=~/.task/hooks
        sync.server.origin=http://192.168.1.179:8080
        sync.server.client_id=${secrets.taskwarrior.client_id}
        sync.encryption_secret=${secrets.taskwarrior.encryption_secret}
      '';
      recursive = true;
    };
    ".tmux.conf" = {
      enable = true;
      source = ../../stowed/.tmux.conf;
      recursive = true;
    };
    ".profile" = {
      enable = true;
      source = ../../stowed/.profile;
      recursive = true;
    };
    ".vimrc" = {
      enable = true;
      source = ../../stowed/.vimrc;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
}
