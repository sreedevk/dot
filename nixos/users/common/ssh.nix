{ pkgs, opts, ... }: {

  home.file = {
    "authorized_keys" = {
      enable = true;
      target = ".ssh/authorized_keys.source";
      executable = false;
      recursive = false;
      text = builtins.concatStringsSep "\n" opts.publicKeys;
      onChange = ''
        cat ~/.ssh/authorized_keys.source > ~/.ssh/authorized_keys && chmod 400 ~/.ssh/authorized_keys
      '';
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {

      "sree.dev" = {
        hostname = "sree.dev";
        user = "deploy";
        identityFile = "~/.ssh/devtechnica";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };

      "nullptr.sh" = {
        hostname = "nullptr.sh";
        user = "admin";
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };

      "gitea.nullptr.sh" = {
        hostname = "gitea.nullptr.sh";
        user = "git";
        port = 222;
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };

      "rpi4b" = {
        hostname = "192.168.1.152";
        user = "pi";
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };

    };
  };
}
