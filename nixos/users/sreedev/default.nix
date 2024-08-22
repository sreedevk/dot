{ pkgs, nixpkgs-stable, ... }:
{
  imports = [
    ../common/alacritty.nix
    ../common/autorandr.nix
    ../common/awscli.nix
    ../common/base.nix
    ../common/core-packages.nix
    ../common/dunst.nix
    ../common/fastfetch.nix
    ../common/firefox.nix
    ../common/fontconfig.nix
    ../common/git.nix
    ../common/github.nix
    ../common/gpg.nix
    ../common/htop.nix
    ../common/i3.nix
    ../common/irssi.nix
    ../common/keybase.nix
    ../common/keyboard.nix
    ../common/kitty.nix
    ../common/neovide.nix
    ../common/neovim.nix
    ../common/newsboat.nix
    ../common/opentabletdriver.nix
    ../common/opentabletdriver.nix
    ../common/stylix.nix
    ../common/taskwarrior.nix
    ../common/tmux-sessionizer.nix
    ../common/tmux.nix
    ../common/vim.nix
    ../common/x86-packages.nix
    ../common/xresources.nix
    ../common/zathura.nix
    ../common/zsh.nix
    ./backup.nix
    ./ssh.nix
  ];

  home.packages =
    with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      arandr
      autorandr
      bitwarden-cli
      brightnessctl
      dbeaver-bin
      doctl
      duckdb
      emacs
      feh
      gimp-with-plugins
      glab
      glow
      graphviz
      hledger
      instaloader
      jira-cli-go
      just
      k9s
      kubectl
      libreoffice-fresh
      lmms
      maim
      mdbook
      nemo-with-extensions
      nicotine-plus
      nixpkgs-fmt
      nmap
      nsxiv
      nushell
      openttd
      pandoc
      playerctl
      python311Packages.i3ipc
      python312Packages.supervisor
      qflipper
      rofi
      slack
      spotify
      tea
      texliveFull
      tmuxinator
      yt-dlp
      zola
    ];
}
