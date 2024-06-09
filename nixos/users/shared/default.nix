{ pkgs, secrets, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host sree.dev
        HostName sree.dev
        User deploy
        IdentityFile ~/.ssh/devtechnica

      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes

      Host gitlab.com
        HostName gitlab.com
        User git
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes

      Host nullptrderef1
        HostName nullptrderef1
        User admin
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes
    '';
  };

  home.file = {
    ".taskrc" = {
      enable = true;
      text = ''
        # Color theme (uncomment one to use)
        # include dark-16.theme
        # include dark-256.theme
        # include dark-blue-256.theme
        # include dark-gray-256.theme
        # include dark-gray-blue-256.theme
        # include dark-green-256.theme
        # include dark-red-256.theme
        # include dark-yellow-green.theme
        # include light-16.theme
        # include light-256.theme
        # include no-color.theme
        # include solarized-dark-256.theme
        # include solarized-light-256.theme
        include dark-violets-256.theme
        data.location=~/.task/
        hooks.location=~/.task/hooks
        sync.server.origin=http://192.168.1.179:8080
        sync.server.client_id=${secrets.taskwarrior.client_id}
        sync.encryption_secret=${secrets.taskwarrior.encryption_secret}
      '';
      recursive = true;
    };
    ".tool-versions" = {
      enable = true;
      source = ../../../stowed/.tool-versions;
      recursive = true;
    };
    ".zshrc" = {
      enable = true;
      executable = false;
      recursive = false;
      source = ../../../stowed/.zshrc;
    };
    ".zsh" = {
      enable = true;
      source = ../../../stowed/.zsh;
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
    ".zshenv" = {
      enable = true;
      text = ''
        export JIRA_API_TOKEN="${secrets.jira.token}"
        export CARGO_REGISTRY_TOKEN="${secrets.cargo.token}"
        export DIGITAL_OCEAN_TOKEN="${secrets.digital_ocean.token}"
        export OPEN_WEATHER_API_KEY="${secrets.openweather.token}"
        export PASTEBIN_API_KEY="${secrets.pastebin.token}"
        export WALLHAVEN_API_KEY="${secrets.wallhaven.token}"
        export FRESHRSS_PASSWORD="${secrets.freshrss.password}"
      '';
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
    ".Xresources" = {
      enable = true;
      source = ../../../stowed/.Xresources;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
}
