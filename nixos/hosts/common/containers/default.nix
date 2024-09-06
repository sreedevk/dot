{ config, lib, pkgs, opts, ... }: {
  imports = [
    ./actual.nix
    ./archivebox.nix
    ./aria2.nix
    ./audiobookshelf.nix
    ./authentik.nix
    ./baikal.nix
    ./cloudbeaver.nix
    ./container-registry.nix
    ./docuseal.nix
    ./firefly.nix
    ./flaresolverr.nix
    ./freshrss.nix
    ./gitea.nix
    ./gotify.nix
    ./homebox.nix
    ./homer.nix
    ./jackett.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./jellystat.nix
    ./kavita.nix
    ./linkding.nix
    ./livebook.nix
    ./llama-cpp.nix
    ./memos.nix
    ./metube.nix
    ./minio.nix
    ./navidrome.nix
    ./ntfy.nix
    ./olivetin.nix
    ./ollama.nix
    ./paperless.nix
    ./photoprism.nix
    ./plex.nix
    ./podgrab.nix
    ./portrainer.nix
    ./qbit_manage.nix
    ./qbittorrent.nix
    ./searxng.nix
    ./servarr.nix
    ./stirling-pdf.nix
    ./telemetry.nix
    ./tubearchivist.nix
    ./uptime-kuma.nix
    ./vaultwarden.nix
    ./watchtower.nix
    ./wyl.nix
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = false;
    autoPrune.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podman-compose
  ];
}
