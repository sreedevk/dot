{ config, lib, pkgs, secrets, opts, ... }: {
  imports = [
    ./archivebox.nix
    ./aria2.nix
    ./audiobookshelf.nix
    ./autobrr.nix
    ./baikal.nix
    ./cloudbeaver.nix
    ./docuseal.nix
    ./farfalle.nix
    ./filebrowser.nix
    ./firefly.nix
    ./flaresolverr.nix
    ./freshrss.nix
    ./homebox.nix
    ./homer.nix
    ./huginn.nix
    ./irc.nix
    ./jackett.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./kavita.nix
    ./linkding.nix
    ./livebook.nix
    ./memos.nix
    ./metube.nix
    ./navidrome.nix
    ./ntfy.nix
    ./olivetin.nix
    ./ollama.nix
    ./openbooks.nix
    ./photoprism.nix
    ./plex.nix
    ./portrainer.nix
    ./qbittorrent.nix
    ./servarr.nix
    ./uptime-kuma.nix
    ./vaultwarden.nix
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };

  virtualisation.oci-containers = {
    backend = "podman";
    storageDriver = "zfs";
    logOptions = [
      "max-size=10m"
      "max-file=3"
    ];
  };
}
