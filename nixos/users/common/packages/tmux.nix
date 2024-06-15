{ secrets, pkgs, ... }: {
  home.packages = with pkgs; [
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      tmuxPlugins.extrakto
      tmuxPlugins.jump
      tmuxPlugins.yank
      tmuxPlugins.tmux-thumbs
    ];
    extraConfig = ''
      set -g @thumbs-key U
      set -g @thumbs-reverse enabled
    '';
  };
}
