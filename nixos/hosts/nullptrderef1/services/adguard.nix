{ config, lib, pkgs, secrets, ... }:
{
  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    openFirewall = true;
    extraArgs = [ ];
    settings = {
      http = {
        address = "0.0.0.0:8000";
      };
      filters = [
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          name = "StevenBlack's List";
          ID = 1;
        }
        {
          enabled = true;
          url = "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt";
          name = "DeveloperDan's Advertisements & Tracking List";
          ID = 15;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/easylist.txt";
          name = "EasyList Basic";
          ID = 16;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/easyprivacy.txt";
          name = "EasyList Privacy";
          ID = 17;
        }
        {
          enabled = true;
          url = "https://secure.fanboy.co.nz/fanboy-annoyance.txt";
          name = "Fanboy's Annoyances";
          ID = 18;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/fanboy-social.txt";
          name = "Fanboy's Social";
          ID = 19;
        }
        {
          enabled = true;
          url = "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt";
          name = "Fanboy's Cookiemonster";
          ID = 20;
        }
        {
          enabled = true;
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.plus.txt";
          name = "Adblock Pro Plus";
          ID = 25;
        }
      ];
      dns = {
        bind_host = "0.0.0.0";
        bootstrap_dns = [ "9.9.9.9" "8.8.8.8" "8.8.4.4" ];
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
        };
        rewrites = [
          { domain = "nullptrderef1"; answer = "192.168.1.179"; }
          { domain = "nullptrderef1.local"; answer = "192.168.1.179"; }
          { domain = "sonarr.local"; answer = "192.168.1.179"; }
          { domain = "radarr.local"; answer = "192.168.1.179"; }
          { domain = "qbittorrent.local"; answer = "192.168.1.179"; }
          { domain = "autobrr.local"; answer = "192.168.1.179"; }
          { domain = "portrainer.local"; answer = "192.168.1.179"; }
          { domain = "homebox.local"; answer = "192.168.1.179"; }
          { domain = "homarr.local"; answer = "192.168.1.179"; }
          { domain = "aria.local"; answer = "192.168.1.179"; }
          { domain = "jackett.local"; answer = "192.168.1.179"; }
          { domain = "bitwarden.local"; answer = "192.168.1.179"; }
          { domain = "prowlarr.local"; answer = "192.168.1.179"; }
          { domain = "adguard.local"; answer = "192.168.1.179"; }
          { domain = "cockpit.local"; answer = "192.168.1.179"; }
          { domain = "netdata.local"; answer = "192.168.1.179"; }
          { domain = "huginn.local"; answer = "192.168.1.179"; }
          { domain = "ntfy.local"; answer = "192.168.1.179"; }
          { domain = "kuma.local"; answer = "192.168.1.179"; }
          { domain = "plex.local"; answer = "192.168.1.179"; }
          { domain = "jellyseer.local"; answer = "192.168.1.179"; }
          { domain = "audiobooks.local"; answer = "192.168.1.179"; }
          { domain = "freshrss.local"; answer = "192.168.1.179"; }
          { domain = "filebrowser.local"; answer = "192.168.1.179"; }
          { domain = "photoprism.local"; answer = "192.168.1.179"; }
          { domain = "stash.local"; answer = "192.168.1.179"; }
          { domain = "bazarr.local"; answer = "192.168.1.179"; }
          { domain = "linkding.local"; answer = "192.168.1.179"; }
          { domain = "lidarr.local"; answer = "192.168.1.179"; }
          { domain = "openbooks.local"; answer = "192.168.1.179"; }
          { domain = "kavita.local"; answer = "192.168.1.179"; }
          { domain = "null.local"; answer = "192.168.1.179"; }
          { domain = "whisparr.local"; answer = "192.168.1.179"; }
          { domain = "readarr.local"; answer = "192.168.1.179"; }
          { domain = "metube.local"; answer = "192.168.1.179"; }
          { domain = "jellyfin.local"; answer = "192.168.1.179"; }
          { domain = "rpi4b.local"; answer = "192.168.1.152"; }
          { domain = "devstation.local"; answer = "192.168.1.249"; }
        ];
        upstream_dns = [
          "https://dns10.quad9.net/dns-query"
          "https://extended.dns.mullvad.net/dns-query"
        ];
        upstream_mode = "load_balance";
      };
    };
  };
}
