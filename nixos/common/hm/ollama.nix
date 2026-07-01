{ pkgs
, opts
, ...
}:
{
  services.ollama = {
    enable = true;
    port = 11434;
    host = "127.0.0.1";
    acceleration = opts.gpuaccel;
    package = pkgs.ollama-cuda;
  };
}
