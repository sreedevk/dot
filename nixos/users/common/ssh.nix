{ pkgs, ... }: {
  home.file = {
    "authorized_keys" = {
      enable = true;
      target = ".ssh/authorized_keys.source";
      executable = false;
      recursive = false;
      text = ''
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP
      '';
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
        user = "sreedev";
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "sreedev";
        identityFile = "~/.ssh/devtechnica";
        identitiesOnly = true;
      };
      "nullptrderef1" = {
        hostname = "nullptrderef1";
        user = "admin";
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
