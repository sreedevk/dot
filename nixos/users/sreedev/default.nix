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
    ../common/man.nix
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
      gui-packages = with pkgs; [
        (config.lib.nixGL.wrap pkgs.slack)
        (config.lib.nixGL.wrapOffload pkgs.gimp3-with-plugins)
        (config.lib.nixGL.wrapOffload pkgs.jellyfin-media-player)
        dbeaver-bin
        easyeffects
        ffmpegthumbnailer
        gnome-calculator
        libreoffice-fresh
        lmms
        nemo-with-extensions
        openttd
        pwvucontrol
        sonic-pi
        sqlitebrowser
        wf-recorder
        wofi
      ];

      cli-packages = with pkgs; [
        agenix                   # age based nix secrets
        aria2                    # aria downloader
        asciinema                # terminal recorder
        asciinema-agg            # terminal recorder format converter
        aspell                   # gnu spellchecker
        aspellDicts.en           # aspell english dictionary
        aspellDicts.en-computers # aspell computers dictionary
        aspellDicts.en-science   # aspell science dictionary
        cava                     # audio visualizer
        claude-code              # coding agent
        cmatrix                  # matrix
        csvlens                  # csv tui viewer
        doxygen                  # source code document generator
        duckdb                   # duck db
        elan                     # lean version manager
        emacs-gtk                # emacs
        fasm                     # flat assembler
        glab                     # gitlab cli
        glow                     # tui markdown renderer
        gpg-tui                  # gnupg tui
        gping                    # ping grapher
        graphviz                 # graph visualizer
        hexyl                    # cli hex viewer
        hledger                  # plain text cli accounting
        hledger-iadd             # hledger interactively add transactions
        hledger-ui               # hledger tui
        hledger-utils            # hledger utils
        hledger-web              # hledger web ui
        html-tidy                # HTML validator
        hyperfine                # benchmarking tool
        imager                   # Interferometric imaging package
        instaloader              # instagram downloader
        ipcalc                   # ip math
        jira-cli-go              # jira
        jless                    # json pager
        just                     # command runner
        k9s                      # k8s tui
        kubectl                  # k8s
        lazydocker               # docker tui
        ledger                   # cli ledger
        mc                       # midnight commander file manager
        mdbook                   # generate books from markdown
        miller                   # awk, sed, cut, join and sort for csv, tsv, json
        nasm                     # x86_64 assembler
        nerd-fonts.iosevka       # iosevka nerd font
        nerd-fonts.iosevka-term  # iosevka term nerd font
        nixfmt                   # nix formatter
        nmap                     # network discovery and security auditing
        nushell                  # modern shell written in rust
        opencode                 # AI coding agent
        pandoc                   # document format converter
        qrencode                 # qr code generator
        s3cmd                    # s3 cli
        sc-im                    # vim like tui spreadsheet
        scdl                     # soundcloud download
        silicon                  # code screenshot generator
        statix                   # nix code linter
        streamrip                # tidal / soundcloud / deezer downloader cli
        tea                      # gitea cli tool
        terminaltexteffects      # cli text effects
        ticker                   # asset ticker
        tmux-sessionizer-package # tmux sessionizer
        tmuxinator               # tmuxinator
        toilet                   # fancy large cli text generator
        tokei                    # lines of code count
        tty-clock                # tty clock
        uiua                     # array oriented programming language
        uv                       # python package manager
        visidata                 # terminal multitool for tabular data
        wiremix                  # tui for pipewire audio control
        yt-dlp                   # youtube downloader
      ];
    in
    builtins.concatLists [
      gui-packages
      cli-packages
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
