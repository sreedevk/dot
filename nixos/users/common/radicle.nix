{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    radicle-httpd
    radicle-node
    inputs.radicle-tui.packages.${system}.default
  ];
}
