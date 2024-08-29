{ config, pkgs, ... }: {

  programs.zsh.enable = true;

  home.file = {
    ".zshrc" = {
      enable = true;
      executable = false;
      recursive = false;
      source = ../../../stowed/.zshrc;
    };

    ".zsh/aliases.zsh" = {
      enable = true;
      source = ../../../stowed/.zsh/aliases.zsh;
      target = ".zsh/aliases.zsh";
      recursive = true;
    };

    ".zsh/zinit.zsh" = {
      enable = true;
      source = ../../../stowed/.zsh/zinit.zsh;
      target = ".zsh/zinit.zsh";
      recursive = true;
    };

    ".zsh/autoloads.zsh" = {
      enable = true;
      source = ../../../stowed/.zsh/autoloads.zsh;
      target = ".zsh/autoloads.zsh";
      recursive = true;
    };

    ".zsh/functions.zsh" = {
      enable = true;
      source = ../../../stowed/.zsh/functions.zsh;
      target = ".zsh/functions.zsh";
      recursive = true;
    };

    ".zsh/plugins.zsh" = {
      enable = true;
      recursive = false;
      target = ".zsh/plugins.zsh";
      text = ''
        [ -f "${pkgs.fzf}/share/fzf/key-bindings.zsh" ] && zvm_after_init_commands+=("source ${pkgs.fzf}/share/fzf/key-bindings.zsh")
        [ -f "${pkgs.fzf}/share/fzf/completion.zsh"   ] && zvm_after_init_commands+=("source ${pkgs.fzf}/share/fzf/completion.zsh")
      '';
    };

    ".zshenv" = {
      enable = true;
      text = ''
        [ -f "$HOME/.zshenv_lc" ] && . "$HOME/.zshenv_lc"
        export JIRA_API_TOKEN="$(cat ${config.age.secrets.jira-token.path})"
        export CARGO_REGISTRY_TOKEN="$(cat ${config.age.secrets.cargo-token.path})"
        export DIGITAL_OCEAN_TOKEN="$(cat ${config.age.secrets.digitalocean-token.path})"
        export OPEN_WEATHER_API_KEY="$(cat ${config.age.secrets.openweather-token.path})"
        export PASTEBIN_API_KEY="$(cat ${config.age.secrets.pastebin-token.path})"
        export WALLHAVEN_API_KEY="$(cat ${config.age.secrets.wallhaven-token.path})"
        export GH_TOKEN="$(cat ${config.age.secrets.gh-token.path})"
        export SPOTIFY_CLIENT_ID="$(cat ${config.age.secrets.spotify_client_id.path})"
        export SPOTIFY_CLIENT_SECRET="$(cat ${config.age.secrets.spotify_client_secret.path})"
        export TASKWARRIOR_CLIENT_ID="$(cat ${config.age.secrets.taskwarrior_client_id.path})"
        export TASKWARRIOR_ENCRYPTION_SECRET="$(cat ${config.age.secrets.taskwarrior_encryption_secret.path})"
      '';
    };
  };
}
