{ pkgs, config, ... }:
{
  imports = [
    ./profiles/main
    ./profiles/personal
  ];
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    package = pkgs.firefox-bin;
  };
}
