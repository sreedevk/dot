{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/misc.nix
    ./common/packages/cli.nix
    ./common/ssh.nix
    ./common/packages/tmux.nix
    ./common/systemd.nix
    ./common/taskwarrior.nix
    ./common/zsh.nix
  ];

  home.packages = with pkgs; [
    asdf-vm
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
