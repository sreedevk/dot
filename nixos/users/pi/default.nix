{ opts, ... }:
{

  imports = [
    ../../secmap.nix
    ../common/base.nix
    ../common/core-min.nix
    ../common/fastfetch.nix
    ../common/git.nix
    ../common/htop.nix
    ../common/neovim.nix
    ../common/pueue.nix
    ../common/radicle
    ../common/starship.nix
    ../common/supervisor
    ../common/tmux.nix
    ../common/vim.nix
    ../common/zsh.nix
  ];

  home.file = {
    "authorized_keys" = {
      enable = true;
      target = ".ssh/authorized_keys.source";
      executable = false;
      recursive = false;
      text = builtins.concatStringsSep "\n" (
        with opts.publicKeys;
        [
          devstation
          nullptrderef1
          rpi4b
          terminus
        ]
      );
      onChange = ''
        rm -rf ~/.ssh/authorized_keys && cat ~/.ssh/authorized_keys.source > ~/.ssh/authorized_keys && chmod 400 ~/.ssh/authorized_keys
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
      "sree.dev" = {
        hostname = "sree.dev";
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
        hostname = "192.168.1.179";
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "gitea.nullptr.sh" = {
        hostname = "git.external.nullptr.sh";
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
    };
  };
}
