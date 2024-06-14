{ secrets, pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    autorandr
    autotiling
    awscli2
    dunst
    emacs
    floorp
    jira-cli-go
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
