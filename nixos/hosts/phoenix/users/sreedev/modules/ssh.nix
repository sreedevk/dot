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
          phoenix
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

      "sree.dev" = {
        Hostname = "sree.dev";
        User = "deploy";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "devtechnica.com devtechnica" = {
        Hostname = "devtechnica.com";
        User = "deploy";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "github.com" = {
        Hostname = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "nullptr.sh" = {
        Hostname = opts.addresses.tailscale.apollo;
        User = "admin";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "apollo" = {
        Hostname = opts.addresses.lan.apollo;
        User = "admin";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "orion" = {
        Hostname = opts.addresses.tailscale.orion;
        User = "u0";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "rocknix-rk3566" = {
        Hostname = opts.addresses.tailscale.rocknix;
        User = "root";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "git.devtechnica.com" = {
        Hostname = "git.devtechnica.com";
        User = "git";
        Port = 222;
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "gitlab.com" = {
        Hostname = "gitlab.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "rpi4b.lan" = {
        Hostname = opts.addresses.lan.rpi4b;
        User = "pi";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "lyra.lan" = {
        Hostname = opts.addresses.lan.lyra;
        User = "admin";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      # vega is a microvm on rpi4b, reached through its forwarded port (2222 -> 22).
      "vega.lan" = {
        Hostname = opts.addresses.lan.rpi4b;
        User = "admin";
        Port = 2222;
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "rpi4b" = {
        Hostname = opts.addresses.tailscale.rpi4b;
        User = "pi";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
