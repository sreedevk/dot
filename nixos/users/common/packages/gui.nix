{ pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    autorandr
    autotiling
    awscli2
    droidcam
    dunst
    emacs
    floorp
    jira-cli-go
    spotify
    cinnamon.nemo-with-extensions
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
