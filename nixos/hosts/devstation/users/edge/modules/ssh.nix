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
          apollo
          rpi4b
          terminus
        ]
      );
      onChange = ''
        cat ~/.ssh/authorized_keys.source > ~/.ssh/authorized_keys
        chmod 400 ~/.ssh/authorized_keys
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

      "devtechnica.com" = {
        hostname = "devtechnica.com";
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
        hostname = opts.addresses.tailscale.apollo;
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "apollo" = {
        hostname = opts.addresses.lan.apollo;
        user = "admin";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };

      "rocknix-rk3566" = {
        hostname = opts.addresses.tailscale.rocknix;
        user = "root";
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
        hostname = opts.addresses.lan.rpi4b;
        user = "pi";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
