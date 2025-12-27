{ pkgs
, config
, username
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
    ../../../../common/hm/fastfetch.nix
    ../../../../common/hm/firefox
    ../../../../common/hm/fontconfig.nix
    ../../../../common/hm/git.nix
    ../../../../common/hm/github.nix
    ../../../../common/hm/gpg.nix
    ../../../../common/hm/htop.nix
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
    ../../../../common/hm/niri
    ../../../../common/hm/nixpkgs.nix
    ../../../../common/hm/noctalia
    ../../../../common/hm/nsxiv.nix
    ../../../../common/hm/obs.nix
    ../../../../common/hm/ocaml.nix
    ../../../../common/hm/opentabletdriver.nix
    ../../../../common/hm/pamshim.nix
    ../../../../common/hm/pueue.nix
    ../../../../common/hm/starship.nix
    ../../../../common/hm/stylix.nix
    ../../../../common/hm/tmux.nix
    ../../../../common/hm/vicinae.nix
    ../../../../common/hm/vim.nix
    ../../../../common/hm/xdg.nix
    ../../../../common/hm/xresources.nix
    ../../../../common/hm/yazi
    ../../../../common/hm/zathura.nix
    ../../../../common/hm/zellij.nix
    ../../../../common/hm/zsh.nix

    # Current User Specific
    ./modules/packages.nix
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
    WALLHAVEN_API_KEY = "$(cat ${config.age.secrets.wallhaven-token.path})";
  };

  nix = {
    package = pkgs.nixVersions.nix_2_28;

    settings = {

      allowed-users = [
        username
      ];
      download-buffer-size = 4000000000;
      fallback = true;
      auto-optimise-store = true;
      http2 = false;
      show-trace = true;
      trusted-users = [
        username
      ];
      warn-dirty = true;

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
        "https://vicinae.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:Ji+ZysQ8GqEtvQF3o4O5q6c3y8C3b2q9p5g6s7d8e9k="
        "devstation:FB1QNgS2s/Guv4hZvFMevbbP6ABvsOMygQbBeKnHf4E="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];

      trusted-substituters = [
        "https://attic.nullptr.sh/devstation"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://numtide.cachix.org"
        "https://colmena.cachix.org"
        "https://vicinae.cachix.org"
      ];

    };
  };

}
