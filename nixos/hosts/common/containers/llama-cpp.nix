{ opts, secrets, ... }:
let
  models = {
    meta-llama-3 = "meta-llama-3-8b-instruct.Q5_K.gguf";
    gemma-2 = "gemma-2-27b-it-Q4_K_L.gguf";
    dolphin-mistral-2-7b = "dolphin-2.2.1-mistral-7b.Q6_K.gguf";
    dolphin-mistral-nemo = "dolphin-2.9.3-mistral-nemo-Q5_K_S.gguf";
    codellama-7b = "codellama-7b.Q6_K.gguf";
  };

  llama-cpp-opts = {
    model = models.meta-llama-3;
    n = "512";
  };
in
{
  virtualisation.oci-containers.containers = {
    "llama-cpp-server" = {
      autoStart = true;
      image = "ghcr.io/ggerganov/llama.cpp:server";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.llama-cpp-server}:8000" ];
      volumes = [ "${opts.paths.llama-cpp-models}:/models:ro" ];
      entrypoint = "/llama-server";
      cmd = [ "-m" "/models/${llama-cpp-opts.model}" "--port" "8000" "--host" "0.0.0.0" "-n" "${llama-cpp-opts.n}" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
