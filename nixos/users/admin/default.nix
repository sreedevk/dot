{ configs, pkgs, secrets, opts, username, ... }: {
  imports = [
    ../common/base.nix
    ../common/beets.nix
    ../common/cargo.nix
    ../common/core-packages.nix
    ../common/fastfetch.nix
    ../common/git.nix
    ../common/htop.nix
    ../common/keybase.nix
    ../common/neovim.nix
    ../common/tmux.nix
    ../common/vim.nix
    ../common/x86-packages.nix
    ../common/zsh.nix
    ./ssh.nix
  ];
}
