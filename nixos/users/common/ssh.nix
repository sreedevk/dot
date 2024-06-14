{ pkgs, secrets, ... }: {
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
    extraConfig = ''
      Host sree.dev
        HostName sree.dev
        User deploy
        IdentityFile ~/.ssh/devtechnica

      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes

      Host gitlab.com
        HostName gitlab.com
        User git
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes

      Host nullptrderef1
        HostName nullptrderef1
        User admin
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes

      Host rpi4b
        HostName 192.168.1.152
        User pi
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes
    '';
  };
}
