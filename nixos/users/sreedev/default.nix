{ pkgs, ... }:
{
  imports = [
    ../common/alacritty.nix
    ../common/autorandr.nix
    ../common/autotiling.nix
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
    let
      cli-tools =
        with pkgs; [
          awscli2
          doctl
          duckdb
          glab
          glow
          hledger
          instaloader
          irssi
          jira-cli-go
          just
          k9s
          mdbook
          nixpkgs-fmt
          nmap
          nushell
          pandoc
          tea
          texliveFull
          tmuxinator
          yt-dlp
          zola
        ];

      gui-tools =
        with pkgs; [
          (nerdfonts.override { fonts = [ "Iosevka" ]; })
          arandr
          autorandr
          autotiling
          brightnessctl
          dbeaver-bin
          droidcam
          dunst
          emacs
          feh
          gimp-with-plugins
          libreoffice-fresh
          lmms
          maim
          nemo-with-extensions
          nicotine-plus
          nsxiv
          openttd
          playerctl
          python311Packages.i3ipc
          python312Packages.supervisor
          qflipper
          rofi
          slack
          spotify
        ];
    in
    builtins.concatLists [
      cli-tools
      gui-tools
    ];
}
