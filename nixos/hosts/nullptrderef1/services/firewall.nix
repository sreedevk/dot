{ config, pkgs, opts, secrets, ... }:
let
  mkPort = port_str: if builtins.isString port_str then pkgs.lib.strings.toInt port_str else port_str;
in
{
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = builtins.map mkPort [
      opts.apps.memos.app_port
      opts.apps.archivebox.app_port
      opts.apps.aria2.app_port
      opts.apps.aria2.rpc_port
      opts.apps.audiobookshelf.app_port
      opts.apps.autobrr.app_port
      opts.apps.baikal.app_port
      opts.apps.cloudbeaver.app_port
      opts.apps.docuseal.app_port
      opts.apps.flaresolverr.app_port
      opts.apps.freshrss.app_port
      opts.apps.kavita.app_port
      opts.apps.linkding.app_port
      opts.apps.plex.app_port
      opts.apps.searxng.app_port
      opts.apps.farfalle.app_port
      opts.apps.farfalle.api_port
      opts.apps.filebrowser.app_port
      opts.apps.rss-bridge.app_port
      opts.apps.homebox.app_port
      opts.apps.homer.app_port
      opts.apps.huginn.app_port
      opts.apps.znc.app_port
      opts.apps.thelounge.app_port
      opts.apps.jackett.app_port
      opts.apps.jellyseer.app_port
      opts.apps.jellyfin.app_port
      secrets.firefly.app.port
      secrets.firefly.database.port
      secrets.photoprism.app.port
      secrets.photoprism.database.port
      21
      22
      53
      443
      2442 # Grafana
      3001 # Uptime Kuma
      3134 # Ollama Web
      3333 # Huginn
      4533 # Navidrome
      5055 # JellySeer
      6767 # Bazarr
      6881 # qBittorrent Nox
      6969 # aar
      7777 # Ntfy
      7878 # Radarr
      8000 # Adguard
      8001 # qBittorrent WebUI
      8004 # OpenBooks
      8008 # Cockpit
      8024 # Portrainer 1
      8080 # TaskChampion Sync Server
      8081 # MeTube
      8099 # IceCast
      8686 # Lidarr
      8787 # Readarr
      8989 # Sonarr
      9000 # TheLounge
      9001 # Prometheus
      9002 # Prometheus Node
      9080 # Portrainer 2
      9443 # Portrainer 3
      9696 # Prowlarr
      9801 # VaultWarden
      11434 # Ollama API
      19999 # NetData
    ];
    allowedUDPPorts = builtins.map mkPort [
      opts.apps.jellyfin.app_port
      21
      22
      53
      6881 # qBittorrent Nox
      13378 # AudioBook Shelf
    ];
  };
}
