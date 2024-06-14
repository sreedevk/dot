{ configs, pkgs, secrets, ... }: {
  imports = [ ./shared ];
  home = {
    username = "pi";
    homeDirectory = "/home/pi";
    stateVersion = "23.11";
    packages = with pkgs; [
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
  };

  stylix = {
    enable = false;
  };

  programs.zsh.enable = true;
}
