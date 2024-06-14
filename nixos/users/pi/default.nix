{ configs, pkgs, secrets, username, ... }: {
  imports = [ ../shared ];

  home.packages = with pkgs; [
    asdf-vm
    babashka
    delta
    dig
    gh
    git
    git-crypt
    glab
    less
    neovim
    nodejs-slim
    ruby
    tmux
    tmuxPlugins.extrakto
    tmuxPlugins.jump
    tmuxPlugins.tmux-thumbs
    tmuxPlugins.yank
    tree-sitter
    zsh
  ];

  stylix = {
    enable = false;
  };

  programs.zsh.enable = true;
}
