{ pkgs, opts, ... }: {
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
        identityFile = "~/.ssh/devtechnica";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "nullptr.sh" = {
        hostname = "100.117.8.42";
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "gitea.nullptr.sh" = {
        hostname = "100.117.8.42";
        user = "git";
        port = 222;
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };

      "rpi4b" = {
        hostname = "192.168.1.152";
        user = "pi";
        identitiesOnly = true;
        identityFile = "~/.ssh/devtechnica";
      };
    };
  };
}
