{ configs, pkgs, secrets, username, ... }: {
  imports = [ ../shared ../common/packages/tmux.nix ];

  home.packages = with pkgs; [
    asdf-vm
    git
    git-crypt
    neovim
    nodejs-slim
    ruby
    zsh
  ];

  stylix = {
    enable = false;
  };

  programs.zsh.enable = true;
}
