{ secrets, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    extraConfig = builtins.readFile ../../../../stowed/.tmux.conf;
    historyLimit = 100000;
    plugins = with pkgs; [
      tmuxPlugins.extrakto
      tmuxPlugins.jump
      tmuxPlugins.yank
      tmuxPlugins.tmux-thumbs
    ];
  };
}
