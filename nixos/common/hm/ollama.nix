{ pkgs
, config
, opts
, ...
}:
{
  services.ollama = {
    enable = true;
    port = 11434;
    host = "127.0.0.1";
    acceleration = opts.gpuaccel;
    package = config.lib.nixGL.wrapOffload pkgs.ollama;
  };
}
