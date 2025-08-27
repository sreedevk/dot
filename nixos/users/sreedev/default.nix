{ pkgs
, config
, inputs
, ...
}:
let
  tmux-sessionizer-package = import ../common/tmux-sessionizer.nix { inherit pkgs; };
in
{
  imports = [
    ../../secmap.nix
    ../common/alacritty
    ../common/amfora.nix
    ../common/awscli.nix
    ../common/base.nix
    ../common/bitwarden.nix
    ../common/brave.nix
    ../common/btop.nix
    ../common/core-max.nix
    ../common/droidcam.nix
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
    ../common/mise.nix
    ../common/neovide.nix
    ../common/neovim.nix
    ../common/newsboat.nix
    ../common/nsxiv.nix
    ../common/obs.nix
    ../common/ocaml.nix
    ../common/ollama.nix
    ../common/opentabletdriver.nix
    ../common/pueue.nix
    ../common/radicle
    ../common/rofi
    ../common/starship.nix
    ../common/stylix.nix
    ../common/supervisor
    ../common/taskwarrior.nix
    ../common/tmux.nix
    ../common/vim.nix
    ../common/xresources.nix
    ../common/zathura.nix
    ../common/zellij.nix
    ../common/zsh.nix
    ./autorandr.nix
    ./restic.nix
  ];

  nixGL = {
    inherit (inputs.nixgl) packages;
    defaultWrapper = "mesa";
    offloadWrapper = "nvidia";
    vulkan.enable = true;
    installScripts = [
      "mesa"
      "nvidia"
    ];
  };

  home.packages =
    let
      stable = {
        gui-packages = with pkgs; [
          (config.lib.nixGL.wrap pkgs.slack)
          (config.lib.nixGL.wrapOffload pkgs.jellyfin-media-player)
          dbeaver-bin
          eww
          libreoffice-fresh
          nemo-with-extensions
          openttd
          pwvucontrol
          qflipper
          quickshell
          sonic-pi
          sqlitebrowser
          wofi
        ];
        cli-packages = with pkgs; [
          agenix
          aria2
          asciinema
          asciinema-agg
          aspell
          aspellDicts.en
          aspellDicts.en-computers
          aspellDicts.en-science
          beanstalkd
          cava
          claude-code
          cmatrix
          csvlens
          doctl
          duckdb
          elan
          emacs-gtk
          fasm
          glab
          glow
          gpg-tui
          gping
          graphviz
          hexyl
          hledger
          hledger-iadd
          hledger-ui
          hledger-utils
          hledger-web
          html-tidy
          hugo
          hyperfine
          id3v2
          imager
          instaloader
          ipcalc
          jira-cli-go
          jless
          just
          k9s
          kubectl
          lazydocker
          ledger
          mdbook
          miller
          nasm
          ncpamixer
          nerd-fonts.iosevka
          nerd-fonts.iosevka
          nerd-fonts.iosevka-term
          nixfmt
          nixpkgs-fmt
          nmap
          nushell
          opencode
          oxker
          pandoc
          poezio
          pulsemixer
          qrencode
          s3cmd
          sc-im
          scdl
          silicon
          statix
          tea
          terminaltexteffects
          ticker
          tmux-sessionizer-package
          tmuxinator
          toilet
          tokei
          tty-clock
          uiua
          uv
          visidata
          yt-dlp
        ];
      };
    in
    builtins.concatLists [
      stable.gui-packages
      stable.cli-packages
    ];

  home.file = {
    ".zshenv" = {
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
        export RAD_PASSPHRASE="$(cat ${config.age.secrets.radicle_passphrase.path})"
        export CR_PAT="$(cat ${config.age.secrets.ghcr_ro_token.path})"
        export RESTIC_PASSWORD_FILE="${config.age.secrets.restic_backup_password.path}"
        export RESTIC_REPOSITORY=sftp:nullptrderef1:/mnt/dpool0/backups/devstation/restic-repository
      '';
    };
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    extraOptionOverrides = {
      StrictHostKeyChecking = "no";
      LogLevel = "ERROR";
    };

    matchBlocks = {
      "*" = {
        userKnownHostsFile = "/dev/null";
      };

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

      "op7pro-termux" = {
        hostname = "100.99.63.104";
        user = "u0_a256";
        port = 8022;
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "rocknix-rk3566" = {
        hostname = "100.100.18.78";
        user = "root";
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

      "git.devtechnica.com" = {
        hostname = "git.devtechnica.com";
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
        hostname = "192.168.1.151";
        user = "pi";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

}
