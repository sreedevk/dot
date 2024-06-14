{ secrets, pkgs, ... }: {
  home.packages = with pkgs; [
    tmux
    tmuxPlugins.extrakto
    tmuxPlugins.jump
    tmuxPlugins.tmux-thumbs
    tmuxPlugins.yank
  ];
}
