{ opts, secrets, ... }:
{
  virtualisation.oci-containers.containers = {
    "llama-cpp-server" = {
      autoStart = true;
      image = "ghcr.io/ggerganov/llama.cpp:server";
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
        "--memory=16g"
        "--memory-swap=32g"
        "--cpus=4"
      ];
      ports = [ "${opts.ports.llama-cpp-server}:8000" ];
      volumes = [ "${opts.paths.llama-cpp-models}:/models:ro" ];
      entrypoint = "/llama-server";
      cmd = [ "-m" "/models/dolphin-2.2.1-mistral-7b.Q6_K.gguf" "--port" "8000" "--host" "0.0.0.0" "-n" "512" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
