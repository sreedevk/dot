{ config, lib, pkgs, secrets, opts, ... }: {
  imports = [
    ./actual.nix
    ./archivebox.nix
    ./aria2.nix
    ./audiobookshelf.nix
    ./autobrr.nix
    ./baikal.nix
    ./calibre-web.nix
    ./cloudbeaver.nix
    ./container-registry.nix
    ./docuseal.nix
    ./excalidraw.nix
    ./filebrowser.nix
    ./firefly.nix
    ./flaresolverr.nix
    ./freshrss.nix
    ./gitea.nix
    ./gotify.nix
    ./homebox.nix
    ./homer.nix
    ./huginn.nix
    ./jackett.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./kavita.nix
    ./linkding.nix
    ./livebook.nix
    ./llama-cpp.nix
    ./memos.nix
    ./metube.nix
    ./navidrome.nix
    ./nginx.nix
    ./ntfy.nix
    ./olivetin.nix
    ./ollama.nix
    ./paperless.nix
    ./photoprism.nix
    ./plex.nix
    ./podgrab.nix
    ./portrainer.nix
    ./qbittorrent.nix
    ./servarr.nix
    ./tubearchivist.nix
    ./uptime-kuma.nix
    ./vaultwarden.nix
    ./watchtower.nix
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };
}
