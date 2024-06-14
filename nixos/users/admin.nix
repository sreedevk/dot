{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/misc.nix
    ./common/packages/cli.nix
    ./common/packages/tmux.nix
    ./common/ssh.nix
    ./common/systemd.nix
    ./common/taskwarrior.nix
    ./common/zsh.nix
  ];

  home.packages = with pkgs; [
    asdf-vm
    neovim
    ruby
  ];

  stylix = {
    enable = false;
  };

  programs.zsh.enable = true;
}
