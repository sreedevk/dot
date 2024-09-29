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
    ./filebrowser.nix
    ./firefly.nix
    ./flaresolverr.nix
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
    ./memos.nix
    ./metube.nix
    ./miniflux.nix
    ./minio.nix
    ./n8n.nix
    ./navidrome.nix
    ./nginx.nix
    ./olivetin.nix
    ./ollama.nix
    ./paperless.nix
    ./photoprism.nix
    ./podgrab.nix
    ./portainer.nix
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
