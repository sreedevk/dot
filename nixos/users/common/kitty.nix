{ pkgs, lib, ... }:
let
  nixGLSource = builtins.fetchTarball {
    url = "https://github.com/guibou/nixGL/archive/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a.tar.gz";
    sha256 = "1crnbv3mdx83xjwl2j63rwwl9qfgi2f1lr53zzjlby5lh50xjz4n";
  };

  nixGLIntel = (pkgs.callPackage "${nixGLSource}/nixGL.nix" { }).nixGLIntel;
in
{
  programs.kitty = {
    enable = true;
    font = {
      size = lib.mkForce 24;
    };
    package =
      pkgs.writeShellScriptBin "kitty" ''
        #!/bin/sh

        ${nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty "$@"
      '';
  };
}
