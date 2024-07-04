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
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
