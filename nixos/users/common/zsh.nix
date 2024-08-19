{ pkgs, secrets, ... }: {

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
        export JIRA_API_TOKEN="${secrets.jira_token or ""}"
        export CARGO_REGISTRY_TOKEN="${secrets.cargo_token or ""}"
        export DIGITAL_OCEAN_TOKEN="${secrets.digital_ocean_token or ""}"
        export OPEN_WEATHER_API_KEY="${secrets.openweather_token or ""}"
        export PASTEBIN_API_KEY="${secrets.pastebin_token or ""}"
        export WALLHAVEN_API_KEY="${secrets.wallhaven_token or ""}"
        export GH_TOKEN="${secrets.github_token or ""}"
      '';
    };

  };
}
