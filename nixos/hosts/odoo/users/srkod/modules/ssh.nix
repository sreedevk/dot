{ opts, ... }:
{

  services.ssh-agent.enable = true;

  home.file = {
    "authorized_keys" = {
      enable = true;
      target = ".ssh/authorized_keys.source";
      executable = false;
      recursive = false;
      text = builtins.concatStringsSep "\n" (
        with opts.publicKeys;
        [
          terminus
        ]
      );
      onChange = ''
        cat ~/.ssh/authorized_keys.source > ~/.ssh/authorized_keys
        chmod 600 ~/.ssh/authorized_keys
        rm -rf ~/.ssh/authorized_keys.source
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

    settings = {
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
        hostname = opts.addresses.tailscale.apollo;
        user = "admin";
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
