{ config, pkgs, opts, secrets, ... }:
let
  mkPort = port_str: if builtins.isString port_str then pkgs.lib.strings.toInt port_str else port_str;
in
{
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = builtins.map mkPort [
      opts.ports.archivebox
      opts.ports.audiobookshelf
      opts.ports.autobrr
      opts.ports.baikal
      opts.ports.bazarr
      opts.ports.cloudbeaver
      opts.ports.docuseal
      opts.ports.filebrowser
      opts.ports.flaresolverr
      opts.ports.freshrss
      opts.ports.homebox
      opts.ports.homer
      opts.ports.huginn
      opts.ports.jackett
      opts.ports.jellyfin
      opts.ports.jellyseer
      opts.ports.kavita
      opts.ports.linkding
      opts.ports.memos
      opts.ports.metube
      opts.ports.navidrome
      opts.ports.ntfy
      opts.ports.olivetin
      opts.ports.ollama-api
      opts.ports.ollama-web
      opts.ports.openbooks
      opts.ports.plex
      opts.ports.prowlarr
      opts.ports.radarr
      opts.ports.readarr
      opts.ports.rss-bridge
      opts.ports.searxng
      opts.ports.sonarr
      opts.ports.thelounge
      opts.ports.uptime-kuma
      opts.ports.vaultwarden
      opts.ports.znc
      opts.ports.firefly_db
      opts.ports.firefly_app
      opts.ports.farfalle_api
      opts.ports.farfalle_app
      opts.ports.aria_web
      opts.ports.aria_rpc
      opts.ports.photoprism_app
      opts.ports.photoprism_db
      opts.ports.grafana
      opts.ports.prometheus_node
      opts.ports.prometheus_app
      opts.ports.lidarr
      opts.ports.qbittorrent-web
      opts.ports.qbittorrent-p2p
      opts.ports.netdata
      opts.ports.icecast
      opts.ports.adguard_web
      opts.ports.adguard_dns
      opts.ports.portrainer_web
      opts.ports.potrainer_web_secure
      21
      22
      443
      8008 # Cockpit
      8024 # Portrainer 1
      8080 # TaskChampion Sync Server
    ];
    allowedUDPPorts = builtins.map mkPort [
      opts.ports.audiobookshelf
      opts.ports.jellyfin
      opts.ports.qbittorrent-p2p
      opts.ports.adguard_dns
      21
      22
    ];
  };
}
