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
    neovim
    ruby
    tmux
    tmuxPlugins.extrakto
    tmuxPlugins.jump
    tmuxPlugins.tmux-thumbs
    tmuxPlugins.yank
  ];

  stylix = {
    enable = false;
  };

  programs.zsh.enable = true;
}
