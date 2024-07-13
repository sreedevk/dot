{ pkgs, secrets, lib, inputs, opts, system, username, ... }: {
  imports = [
    ./common/autorandr.nix
    ./common/autotiling.nix
    ./common/awscli.nix
    ./common/core-packages.nix
    ./common/dunst.nix
    ./common/fastfetch.nix
    ./common/firefox.nix
    ./common/fontconfig.nix
    ./common/github.nix
    ./common/htop.nix
    ./common/i3.nix
    ./common/keybase.nix
    ./common/keyboard.nix
    ./common/misc.nix
    ./common/newsboat.nix
    ./common/ssh.nix
    ./common/stylix.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/x86-packages.nix
    ./common/zathura.nix
    ./common/zsh.nix
  ];

  home.packages =
    let
      cli-tools = with pkgs; [
        awscli2
        doctl
        duckdb
        glab
        glow
        hledger
        instaloader
        irssi
        jira-cli-go
        k9s
        mdbook
        nixpkgs-fmt
        nushell
        pandoc
        taskwarrior-tui
        tea
        tmuxinator
        yt-dlp
        zola
      ];

      gui-tools = with pkgs; [
        (nerdfonts.override { fonts = [ "Iosevka" ]; })
        arandr
        autorandr
        autotiling
        brightnessctl
        cinnamon.nemo-with-extensions
        dbeaver-bin
        droidcam
        dunst
        emacs
        feh
        floorp
        gimp-with-plugins
        joplin-desktop
        libreoffice-fresh
        lmms
        maim
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
        sxiv
      ];
    in
    builtins.concatLists [ cli-tools gui-tools ];
}
