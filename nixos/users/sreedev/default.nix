{ pkgs, age, config, username, ... }:
{
  imports = [
    ../../../secrets/mappings.nix
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
    ../common/hyprland
    ../common/i3.nix
    ../common/irssi.nix
    ../common/jujutsu.nix
    ../common/keybase.nix
    ../common/keyboard.nix
    ../common/kitty.nix
    ../common/ladybird.nix
    ../common/neovide.nix
    ../common/neovim.nix
    ../common/newsboat.nix
    ../common/obs.nix
    ../common/opentabletdriver.nix
    ../common/radicle.nix
    ../common/slack.nix
    ../common/spotube.nix
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
      filezilla
      gimp-with-plugins
      glab
      glow
      graphviz
      hledger
      hugo
      instaloader
      jira-cli-go
      just
      k9s
      kubectl
      ledger
      librecad
      libreoffice-fresh
      lmms
      maim
      mdbook
      nemo-with-extensions
      nixops_unstable_minimal
      nixpkgs-fmt
      nmap
      nsxiv
      nushell
      nvtopPackages.full
      openttd
      oxker
      pandoc
      playerctl
      python311Packages.i3ipc
      python312Packages.supervisor
      qflipper
      qrencode
      rofi
      scdl
      sonic-pi
      tea
      texliveFull
      tmuxinator
      yt-dlp
    ];

  home.file.".zshenv" = {
    enable = true;
    text = ''
      [ -f "$HOME/.zshenv_lc" ] && . "$HOME/.zshenv_lc"
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
    '';
  };
}
