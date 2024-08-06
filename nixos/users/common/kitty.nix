{ pkgs, lib, config, ... }:
let
  nixGLSource = builtins.fetchTarball {
    url = "https://github.com/guibou/nixGL/archive/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a.tar.gz";
    sha256 = "1crnbv3mdx83xjwl2j63rwwl9qfgi2f1lr53zzjlby5lh50xjz4n";
  };

  nixGLNvidia = (pkgs.callPackage "${nixGLSource}/nixGL.nix" { }).auto.nixGLNvidia;
in
{

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      genericName = "Terminal";
      exec = "kitty";
      icon = "Kitty";
      terminal = false;
      categories = [ "System" "TerminalEmulator" ];
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    font = {
      name = "Iosevka NF";
      size = lib.mkForce 28;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      background_opacity = "0.8";
    };
    package =
      pkgs.writeShellScriptBin "kitty" ''
        #!/bin/sh

        ${nixGLNvidia}/bin/nixGLNvidia-555.58.02 ${pkgs.kitty}/bin/kitty "$@"
      '';
  };
}
