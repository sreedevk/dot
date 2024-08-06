{ pkgs, lib, config, ... }:
let
  nixGLSource = builtins.fetchTarball {
    url = "https://github.com/guibou/nixGL/archive/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a.tar.gz";
    sha256 = "1crnbv3mdx83xjwl2j63rwwl9qfgi2f1lr53zzjlby5lh50xjz4n";
  };

  nixGLNvidia = (pkgs.callPackage "${nixGLSource}/nixGL.nix" { }).auto.nixGLNvidia;
in
{
  programs.alacritty = {
    enable = true;
    package =
      pkgs.writeShellScriptBin "alacritty" ''
        #!/bin/sh

        ${nixGLNvidia}/bin/nixGLNvidia-555.58.02 ${pkgs.alacritty}/bin/alacritty "$@"
      '';
  };
}
