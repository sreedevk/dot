{ pkgs, lib, config, nixpkgs-stable, ... }:
let
  nixglmod = import ../common/nixGL.nix { inherit lib config pkgs; };
in
{
  imports = [
    ../../../secrets/mappings.nix
    ../common/alacritty.nix
    ../common/asdf.nix
    ../common/awscli.nix
    ../common/base.nix
    ../common/btop.nix
    ../common/cargo.nix
    ../common/core-packages.nix
    ../common/dunst.nix
    ../common/fastfetch.nix
    ../common/firefox
    ../common/fontconfig.nix
    ../common/ghostty.nix
    ../common/git.nix
    ../common/github.nix
    ../common/gpg.nix
    ../common/htop.nix
    ../common/hyprland
    ../common/i3.nix
    ../common/jujutsu.nix
    ../common/keybase.nix
    ../common/keyboard.nix
    ../common/kitty
    ../common/neovide.nix
    ../common/neovim.nix
    ../common/newsboat.nix
    ../common/nsxiv.nix
    ../common/opentabletdriver.nix
    ../common/rofi
    ../common/stylix.nix
    ../common/taskwarrior.nix
    ../common/tmux-sessionizer.nix
    ../common/tmux.nix
    ../common/vim.nix
    ../common/xresources.nix
    ../common/zathura.nix
    ../common/zellij.nix
    ../common/zsh.nix
    ./autorandr.nix
    ./backup.nix
  ];

  home.packages =
    let
      stable-packages = with nixpkgs-stable; [
        (nerdfonts.override { fonts = [ "Iosevka" ]; })
      ];

      nixgl-packages = [
        (nixglmod.nixGLWrapped pkgs.slack "slack")
        (nixglmod.nixGLWrapped pkgs.spotube "spotube")
      ];

      unstable-packages = with pkgs; [
        amfora
        aria2
        asciinema
        asciinema-agg
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        beanstalkd
        bitwarden-cli
        cava
        cmatrix
        csvlens
        dbeaver-bin
        doctl
        duckdb
        emacs
        fasm
        filezilla
        gimp-with-plugins
        glab
        glow
        gping
        graphviz
        hexyl
        hledger
        hledger-iadd
        hledger-ui
        hledger-utils
        hledger-web
        hugo
        id3v2
        instaloader
        jira-cli-go
        just
        k9s
        kubectl
        ledger
        librecad
        libreoffice-fresh
        lmms
        mdbook
        ncdu
        nemo-with-extensions
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nixpkgs-fmt
        nmap
        nushell
        openttd
        oxker
        pandoc
        puffin
        pwvucontrol
        python312Packages.supervisor
        qflipper
        qrencode
        radicle-httpd
        radicle-node
        rebar3
        scdl
        sonic-pi
        tea
        terminaltexteffects
        texliveFull
        tmuxinator
        visidata
        yt-dlp
      ];
    in
    stable-packages ++ unstable-packages ++ nixgl-packages;

  home.file.".zshenv" = {
    enable = true;
    text = ''
      export JIRA_API_TOKEN="$(cat ${config.age.secrets.jira-token.path})"
      export CARGO_REGISTRY_TOKEN="$(cat ${config.age.secrets.cargo-token.path})"
      export DIGITAL_OCEAN_TOKEN="$(cat ${config.age.secrets.digitalocean-token.path})"
      export OPEN_WEATHER_API_KEY="$(cat ${config.age.secrets.openweather-token.path})"
      export PASTEBIN_API_KEY="$(cat ${config.age.secrets.pastebin-token.path})"
      export WALLHAVEN_API_KEY="$(cat ${config.age.secrets.wallhaven-token.path})"
      export GH_TOKEN="$(cat ${config.age.secrets.gh-token.path})"
      export SPOTIFY_CLIENT_ID="$(cat ${config.age.secrets.spotify_client_id.path})"
      export SPOTIFY_CLIENT_SECRET="$(cat ${config.age.secrets.spotify_client_secret.path})"
      export TASKWARRIOR_CLIENT_ID="$(cat ${config.age.secrets.taskwarrior_client_id.path})"
      export TASKWARRIOR_ENCRYPTION_SECRET="$(cat ${config.age.secrets.taskwarrior_encryption_secret.path})"
      export BW_SESSION="$(cat ${config.age.secrets.bw_session.path})"
      export HUGGING_FACE_TOKEN="$(cat ${config.age.secrets.hugging_face_token.path})"
      export OPENAI_API_KEY="$(cat ${config.age.secrets.openai_api_key.path})"
    '';
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "/dev/null";
    extraOptionOverrides = {
      StrictHostKeyChecking = "no";
      LogLevel = "ERROR";
    };

    matchBlocks = {
      "sree.dev" = {
        hostname = "sree.dev";
        user = "deploy";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "devtechnica.com" = {
        hostname = "devtechnica.com";
        user = "deploy";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "nullptr.sh" = {
        hostname = "100.117.8.42";
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "nullptrderef1" = {
        hostname = "192.168.1.179";
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "gitea.nullptr.sh" = {
        hostname = "100.117.8.42";
        user = "git";
        port = 222;
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "rpi4b" = {
        hostname = "192.168.1.152";
        user = "pi";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

}
