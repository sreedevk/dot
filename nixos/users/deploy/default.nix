{ opts, ... }: {

  imports = [
    ../../../secrets/mappings.nix
    ../common/asdf.nix
    ../common/base.nix
    ../common/btop.nix
    ../common/cargo.nix
    ../common/core-packages.nix
    ../common/fastfetch.nix
    ../common/git.nix
    ../common/htop.nix
    ../common/jujutsu.nix
    ../common/starship.nix
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
      text = builtins.concatStringsSep "\n" (with opts.publicKeys; [
        devstation
        rpi4b
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
      "github.com" = {
        hostname = "github.com";
        user = "git";
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
