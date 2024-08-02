{ pkgs, opts, ... }: {
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "/dev/null";
    extraOptionOverrides = {
      StrictHostKeyChecking = "no";
    };

    matchBlocks = {
      "sree.dev" = {
        hostname = "sree.dev";
        user = "deploy";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "nullptr.sh" = {
        hostname = "192.168.1.179";
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
        proxyJump = "rpi4b";
      };

      "gitea.nullptr.sh" = {
        hostname = "192.168.1.179";
        user = "git";
        port = 222;
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
        proxyJump = "rpi4b";
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "rpi4b" = {
        hostname = "100.66.42.90";
        user = "pi";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

    };
  };
}
