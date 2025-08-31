{ pkgs, ... }:
{
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

  imports = [
    ./archivebox.nix
    ./aria2.nix
    ./audiobookshelf.nix
    ./authentik.nix
    ./bazarr.nix
    ./bitmagnet.nix
    ./cloudbeaver.nix
    ./container-registry.nix
    ./dawarich.nix
    ./dockge.nix
    ./docuseal.nix
    ./filebrowser.nix
    ./firefly.nix
    ./flaresolverr.nix
    ./flemmarr.nix
    ./gitea.nix
    ./gotify.nix
    ./hoarder.nix
    ./homer.nix
    ./jackett.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./jellystat.nix
    ./kapowarr.nix
    ./kavita.nix
    ./kiwix.nix
    ./lidarr.nix
    ./livebook.nix
    ./memos.nix
    ./metube.nix
    ./miniflux.nix
    ./minio.nix
    ./n8n.nix
    ./navidrome.nix
    ./nginx.nix
    ./nzbhydra.nix
    ./olivetin.nix
    ./ollama.nix
    ./paperless.nix
    ./photoprism.nix
    ./pinepods.nix
    ./portainer.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./readarr.nix
    ./recyclarr.nix
    ./romm.nix
    ./sabnzbd.nix
    ./searxng.nix
    ./sonarr.nix
    ./stash.nix
    ./stirling-pdf.nix
    ./tdarr.nix
    ./telemetry.nix
    ./tubearchivist.nix
    ./uptime-kuma.nix
    ./vaultwarden.nix
    ./watchtower.nix
    ./wyl.nix
  ];
}
