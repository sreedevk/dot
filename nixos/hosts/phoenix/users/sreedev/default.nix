{ pkgs
, config
, username
, opts
, ...
}:
{
  imports = [

    # Common Modules

    ../../../../common/hm/agenix.nix
    ../../../../common/hm/alacritty
    ../../../../common/hm/amfora.nix
    ../../../../common/hm/base.nix
    ../../../../common/hm/bash.nix
    ../../../../common/hm/brave.nix
    ../../../../common/hm/btop.nix
    ../../../../common/hm/core-max.nix
    ../../../../common/hm/direnv.nix
    ../../../../common/hm/droidcam.nix
    ../../../../common/hm/emacs
    ../../../../common/hm/fastfetch.nix
    ../../../../common/hm/firefox
    ../../../../common/hm/fish.nix
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
    ../../../../common/hm/kitty
    ../../../../common/hm/librepods.nix
    ../../../../common/hm/man.nix
    ../../../../common/hm/mise.nix
    ../../../../common/hm/neovide.nix
    ../../../../common/hm/neovim.nix
    ../../../../common/hm/newsboat.nix
    ../../../../common/hm/nixpkgs.nix
    ../../../../common/hm/noctalia
    ../../../../common/hm/nsxiv.nix
    ../../../../common/hm/obs.nix
    ../../../../common/hm/ocaml.nix
    ../../../../common/hm/opentabletdriver.nix
    ../../../../common/hm/pamshim.nix
    ../../../../common/hm/pueue.nix
    ../../../../common/hm/radicle
    ../../../../common/hm/starship.nix
    ../../../../common/hm/steam.nix
    ../../../../common/hm/taskwarrior.nix
    ../../../../common/hm/tmux.nix
    ../../../../common/hm/vicinae.nix
    ../../../../common/hm/vim.nix
    ../../../../common/hm/xdg.nix
    ../../../../common/hm/xresources.nix
    ../../../../common/hm/zathura.nix
    ../../../../common/hm/zellij.nix
    ../../../../common/hm/zsh.nix

    # Current User Specific

    ../../secrets.nix
    ./modules/packages
    ./modules/restic.nix
    ./modules/ssh.nix

  ];

  targets.genericLinux.nixGL = {
    packages = pkgs.nixgl;
    defaultWrapper = "mesa";
    offloadWrapper = "nvidia";
    vulkan.enable = true;
    installScripts = [
      "mesa"
      "nvidia"
    ];
  };

  home = {
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
    inherit username;
  };

  home.file = {
    ".config" = {
      enable = true;
      source = ../../../../../stowed/.config;
      recursive = true;
    };
  };

  home.sessionVariables = {
    CARGO_REGISTRY_TOKEN = "$(cat ${config.age.secrets.cargo-token.path})";
    HUGGING_FACE_TOKEN = "$(cat ${config.age.secrets.hugging_face_token.path})";
    JIRA_API_TOKEN = "$(cat ${config.age.secrets.jira-token.path})";
    OPENAI_API_KEY = "$(cat ${config.age.secrets.openai_api_key.path})";
    OPEN_WEATHER_API_KEY = "$(cat ${config.age.secrets.openweather-token.path})";
    PASTEBIN_API_KEY = "$(cat ${config.age.secrets.pastebin-token.path})";
    RADARR_API_KEY = "$(cat ${config.age.secrets.radarr-api-key.path})";
    SONARR_API_KEY = "$(cat ${config.age.secrets.sonarr-api-key.path})";
    WALLHAVEN_API_KEY = "$(cat ${config.age.secrets.wallhaven-token.path})";
    _ZO_EXCLUDE_DIRS = builtins.concatStringsSep ":" [
      "${opts.directories.documents}/*"
      "${opts.directories.finances}/*"
      "${opts.directories.notebook}/*"
      "${opts.directories.downloads}/*"
      "/mnt/*"
      "/nix/*"
      "/opt/*"
    ];
  };

  nix = {
    package = pkgs.nixVersions.nix_2_28;

    settings = {

      allowed-users = [ username ];
      download-buffer-size = 4000000000;
      fallback = true;
      auto-optimise-store = true;
      http2 = false;
      show-trace = true;
      trusted-users = [ username ];
      warn-dirty = true;

      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];

      substituters = builtins.concatLists [
        (if opts.attic.url != null then [ opts.attic.url ] else [ ])
        [
          "https://cache.nixos.org/"
          "https://cuda-maintainers.cachix.org"
          "https://nix-community.cachix.org"
          "https://numtide.cachix.org"
          "https://colmena.cachix.org"
          "https://vicinae.cachix.org"
          "https://colmena.cachix.org"
        ]
      ];

      trusted-public-keys = builtins.concatLists [
        (if opts.attic.key != null then [ opts.attic.key ] else [ ])
        [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cuda-maintainers.cachix.org-1:Ji+ZysQ8GqEtvQF3o4O5q6c3y8C3b2q9p5g6s7d8e9k="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        ]
      ];

      trusted-substituters = builtins.concatLists [
        (if opts.attic.url != null then [ opts.attic.url ] else [ ])
        [
          "https://cache.nixos.org/"
          "https://cuda-maintainers.cachix.org"
          "https://nix-community.cachix.org"
          "https://numtide.cachix.org"
          "https://colmena.cachix.org"
          "https://vicinae.cachix.org"
          "https://colmena.cachix.org"
        ]
      ];

    };
  };

}
