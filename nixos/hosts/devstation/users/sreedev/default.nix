{ pkgs
, config
, opts
, username
, ...
}:
{
  imports = [

    # Common Modules
    ../../../../common/hm/alacritty
    ../../../../common/hm/amfora.nix
    ../../../../common/hm/awscli.nix
    ../../../../common/hm/base.nix
    ../../../../common/hm/brave.nix
    ../../../../common/hm/btop.nix
    ../../../../common/hm/core-max.nix
    ../../../../common/hm/droidcam.nix
    ../../../../common/hm/dunst.nix
    ../../../../common/hm/emacs
    ../../../../common/hm/fastfetch.nix
    ../../../../common/hm/firefox
    ../../../../common/hm/fontconfig.nix
    ../../../../common/hm/ghostty.nix
    ../../../../common/hm/git.nix
    ../../../../common/hm/github.nix
    ../../../../common/hm/gpg.nix
    ../../../../common/hm/htop.nix
    ../../../../common/hm/hyprland
    ../../../../common/hm/jujutsu.nix
    ../../../../common/hm/keybase.nix
    ../../../../common/hm/keyboard.nix
    ../../../../common/hm/man.nix
    ../../../../common/hm/mise.nix
    ../../../../common/hm/neovide.nix
    ../../../../common/hm/neovim.nix
    ../../../../common/hm/newsboat.nix
    ../../../../common/hm/nixpkgs.nix
    ../../../../common/hm/nsxiv.nix
    ../../../../common/hm/obs.nix
    ../../../../common/hm/ocaml.nix
    ../../../../common/hm/ollama.nix
    ../../../../common/hm/opentabletdriver.nix
    ../../../../common/hm/pueue.nix
    ../../../../common/hm/radicle
    ../../../../common/hm/raku.nix
    ../../../../common/hm/rofi
    ../../../../common/hm/starship.nix
    ../../../../common/hm/stylix.nix
    ../../../../common/hm/supervisor
    ../../../../common/hm/taskwarrior.nix
    ../../../../common/hm/tmux.nix
    ../../../../common/hm/vim.nix
    ../../../../common/hm/xdg.nix
    ../../../../common/hm/xresources.nix
    ../../../../common/hm/yazi
    ../../../../common/hm/zathura.nix
    ../../../../common/hm/zellij.nix
    ../../../../common/hm/zsh.nix
    ../../../../common/secrets/mappings.nix

    # Current User Specific
    ./modules/packages.nix
    ./modules/restic.nix
    ./modules/ssh.nix

  ];

  nixGL = {
    packages = pkgs.nixgl;
    defaultWrapper = "mesa";
    offloadWrapper = "nvidia";
    vulkan.enable = true;
    installScripts = [
      "mesa"
      "nvidia"
    ];
  };

  home.file = {

    ".zshenv" = {
      enable = true;
      text = ''
        export CARGO_REGISTRY_TOKEN="$(cat ${config.age.secrets.cargo-token.path})"
        export CR_PAT="$(cat ${config.age.secrets.ghcr_ro_token.path})"
        export DIGITAL_OCEAN_TOKEN="$(cat ${config.age.secrets.digitalocean-token.path})"
        export GH_TOKEN="$(cat ${config.age.secrets.gh-token.path})"
        export HUGGING_FACE_TOKEN="$(cat ${config.age.secrets.hugging_face_token.path})"
        export JIRA_API_TOKEN="$(cat ${config.age.secrets.jira-token.path})"
        export OPENAI_API_KEY="$(cat ${config.age.secrets.openai_api_key.path})"
        export OPEN_WEATHER_API_KEY="$(cat ${config.age.secrets.openweather-token.path})"
        export PASTEBIN_API_KEY="$(cat ${config.age.secrets.pastebin-token.path})"
        export RAD_PASSPHRASE="$(cat ${config.age.secrets.radicle_passphrase.path})"
        export RESTIC_PASSWORD_FILE="${config.age.secrets.restic_backup_password.path}"
        export RESTIC_REPOSITORY=sftp:apollo:/mnt/dpool1/backups/${opts.hostname}/restic-repository
        export TASKWARRIOR_CLIENT_ID="$(cat ${config.age.secrets.taskwarrior_client_id.path})"
        export TASKWARRIOR_ENCRYPTION_SECRET="$(cat ${config.age.secrets.taskwarrior_encryption_secret.path})"
        export WALLHAVEN_API_KEY="$(cat ${config.age.secrets.wallhaven-token.path})"
      '';
    };

  };

  nix = {
    package = pkgs.nixVersions.nix_2_28;

    settings = {

      allowed-users        = [ "${username}" ];
      download-buffer-size = 4000000000;
      fallback             = true;
      auto-optimise-store  = true;
      http2                = false;
      show-trace           = true;
      trusted-users        = [ "${username}" ];
      warn-dirty           = true;

      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];

      substituters = [
        "https://attic.nullptr.sh/devstation"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://numtide.cachix.org"
        "https://colmena.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:Ji+ZysQ8GqEtvQF3o4O5q6c3y8C3b2q9p5g6s7d8e9k="
        "devstation:FB1QNgS2s/Guv4hZvFMevbbP6ABvsOMygQbBeKnHf4E="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      ];
      
      trusted-substituters = [
        "https://attic.nullptr.sh/devstation"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://numtide.cachix.org"
        "https://colmena.cachix.org"
      ];

    };
  };

}
