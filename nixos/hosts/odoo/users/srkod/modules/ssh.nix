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
          phoenix
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
        UserKnownHostsFile = "/dev/null";
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "nullptr.sh" = {
        HostName = opts.addresses.tailscale.apollo;
        User = "admin";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "apollo" = {
        HostName = opts.addresses.lan.apollo;
        User = "admin";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "rpi4b" = {
        HostName = opts.addresses.tailscale.rpi4b;
        User = "pi";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "git.devtechnica.com" = {
        HostName = "git.devtechnica.com";
        User = "git";
        port = 222;
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
