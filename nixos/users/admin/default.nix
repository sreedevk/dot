{ config, ... }: {
  imports = [
    ../../../secrets/mappings.nix
    ../common/base.nix
    ../common/beets.nix
    ../common/cargo.nix
    ../common/core-packages.nix
    ../common/fastfetch.nix
    ../common/git.nix
    ../common/htop.nix
    ../common/jujutsu.nix
    ../common/neovim.nix
    ../common/pueue.nix
    ../common/starship.nix
    ../common/tmux.nix
    ../common/vim.nix
    ../common/zsh.nix
  ];

  home.file = {
    ".zshenv" = {
      enable = true;
      text = ''
        export RAD_PASSPHRASE="$(cat ${config.age.secrets.radicle_passphrase.path})"
      '';
    };
  };

  programs.ssh =
    {
      enable = true;
      userKnownHostsFile = "/dev/null";
      extraOptionOverrides = {
        StrictHostKeyChecking = "no";
        LogLevel = "ERROR";
      };

      matchBlocks = {
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
