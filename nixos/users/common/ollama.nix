{ pkgs, config, ... }:
{
  services.ollama = {
    enable = true;
    port = 11434;
    host = "127.0.0.1";
    acceleration = "cuda";
    package = config.lib.nixGL.wrapOffload pkgs.ollama;
  };
}
