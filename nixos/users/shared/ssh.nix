{ pkgs, secrets, ... }: {
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
