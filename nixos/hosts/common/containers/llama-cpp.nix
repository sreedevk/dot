{ opts, pkgs, secrets, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ llama-cpp-server ]);

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
      cmd = [ "-m" "/models/llama-2-7b-chat.Q5_K_M.gguf" "--port" "8000" "--host" "0.0.0.0" "-n" "512" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
