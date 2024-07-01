{ pkgs, secrets, ... }: {

  home.file = {
    ".zshrc" = {
      enable = true;
      executable = false;
      recursive = false;
      source = ../../../stowed/.zshrc;
    };
    ".zsh-aliases" = {
      enable = true;
      source = ../../../stowed/.zsh/aliases.sh;
      target = ".zsh/aliases.sh";
      recursive = true;
    };
    ".zsh-zinit" = {
      enable = true;
      source = ../../../stowed/.zsh/zinit.sh;
      target = ".zsh/zinit.sh";
      recursive = true;
    };
    ".zsh-autoloads" = {
      enable = true;
      source = ../../../stowed/.zsh/autoloads.sh;
      target = ".zsh/autoloads.sh";
      recursive = true;
    };
    ".zsh-functions" = {
      enable = true;
      source = ../../../stowed/.zsh/functions.sh;
      target = ".zsh/functions.sh";
      recursive = true;
    };
    ".zsh-plugins" = {
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
        export JIRA_API_TOKEN="${secrets.jira_token}"
        export CARGO_REGISTRY_TOKEN="${secrets.cargo_token}"
        export DIGITAL_OCEAN_TOKEN="${secrets.digital_ocean_token}"
        export OPEN_WEATHER_API_KEY="${secrets.openweather_token}"
        export PASTEBIN_API_KEY="${secrets.pastebin_token}"
        export WALLHAVEN_API_KEY="${secrets.wallhaven_token}"
        export FRESHRSS_PASSWORD="${secrets.freshrss_app_password}"
        export GH_TOKEN="${secrets.github_token}"
      '';
    };
  };
}
