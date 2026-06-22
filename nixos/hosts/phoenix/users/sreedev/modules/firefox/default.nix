{ pkgs, config, ... }:
{
  imports = [
    ./profiles/main
  ];
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    package = pkgs.firefox-bin;
  };
}
