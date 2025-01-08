{ pkgs, ... }: {

  programs.zsh.enable = true;

  home.file = {
    ".zshrc" = {
      enable = true;
      executable = false;
      recursive = false;
      source = ../../../stowed/.zshrc;
    };

    ".zsh" = {
      enable = true;
      executable = false;
      recursive = true;
      source = ../../../stowed/.zsh;
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
  };
}
