{ opts, ... }: {

  imports = [
    ../../../secrets/mappings.nix
    ../common/base.nix
    ../common/btop.nix
    ../common/core-packages.nix
    ../common/fastfetch.nix
    ../common/git.nix
    ../common/htop.nix
    ../common/jujutsu.nix
    ../common/tmux.nix
    ../common/vim.nix
  ];

  home.file = {
    "authorized_keys" = {
      enable = true;
      target = ".ssh/authorized_keys.source";
      executable = false;
      recursive = false;
      text = builtins.concatStringsSep "\n" (with opts.publicKeys; [
        devstation
        nullptrderef1
        rpi4b
        terminus
      ]);
      onChange = ''
        rm -rf ~/.ssh/authorized_keys && cat ~/.ssh/authorized_keys.source > ~/.ssh/authorized_keys && chmod 400 ~/.ssh/authorized_keys
      '';
    };
  };

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
        hostname = "xgit.nullptr.sh";
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
