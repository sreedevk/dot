{ config
, pkgs
, username
, ...
}:
{
  imports = [
    ../../../../common/secrets/mappings.nix
    ../../../../common/hm/base.nix
    ../../../../common/hm/beets.nix
    ../../../../common/hm/core-max.nix
    ../../../../common/hm/fastfetch.nix
    ../../../../common/hm/git.nix
    ../../../../common/hm/htop.nix
    ../../../../common/hm/jujutsu.nix
    ../../../../common/hm/neovim.nix
    ../../../../common/hm/pueue.nix
    ../../../../common/hm/starship.nix
    ../../../../common/hm/tmux.nix
    ../../../../common/hm/vim.nix
    ../../../../common/hm/zsh.nix
  ];

  home.file = {
    ".zshenv" = {
      enable = true;
      text = ''
        export RAD_PASSPHRASE="$(cat ${config.age.secrets.radicle_passphrase.path})"
      '';
    };
  };

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
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "nullptr.sh" = {
        hostname = "192.168.1.179";
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "gitea.nullptr.sh" = {
        hostname = "192.168.1.179";
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

  nix = {
    package = pkgs.nixVersions.nix_2_28;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "${username}" ];
      http2 = false;
      allowed-users = [ "${username}" ];
      trusted-substituters = [ "https://cache.nixos.org/" ];
      substituters = [ "https://cache.nixos.org/" ];
      show-trace = true;
      auto-optimise-store = true;
      trusted-public-keys = [ ];
      fallback = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];
    };
  };
}
