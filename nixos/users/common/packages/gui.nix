{ pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    autorandr
    autotiling
    awscli2
    cinnamon.nemo-with-extensions
    dbeaver-bin
    droidcam
    dunst
    emacs
    floorp
    jira-cli-go
    spotify
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
