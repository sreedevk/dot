{ configs, pkgs, secrets, ... }: {
  imports = [ ./shared ];
  home = {
    username = "admin";
    homeDirectory = "/home/admin";
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
      neovim
      ruby
      tmux
      tmuxPlugins.extrakto
      tmuxPlugins.jump
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.yank
    ];
  };

  stylix = {
    enable = false;
  };

  programs.zsh.enable = true;
}
