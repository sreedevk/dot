{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  home.packages = with pkgs; [ ollama ];
  services.ollama = {
    enable = true;
    port = 11434;
    host = "127.0.0.1";
    # acceleration = "cuda";
    # package = nixglmod.nixGLWrapped pkgs.ollama "ollama";
  };
}
