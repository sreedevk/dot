{ pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    autorandr
    autotiling
    awscli2
    dunst
    emacs
    droidcam
    floorp
    jira-cli-go
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
