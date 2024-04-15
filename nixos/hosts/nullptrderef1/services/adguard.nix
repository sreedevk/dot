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
          { domain = "nullptrderef1.arpa"; answer = "192.168.1.179"; }
          { domain = "sonarr.arpa"; answer = "192.168.1.179"; }
          { domain = "radarr.arpa"; answer = "192.168.1.179"; }
          { domain = "qbittorrent.arpa"; answer = "192.168.1.179"; }
          { domain = "autobrr.arpa"; answer = "192.168.1.179"; }
          { domain = "portrainer.arpa"; answer = "192.168.1.179"; }
          { domain = "homebox.arpa"; answer = "192.168.1.179"; }
          { domain = "homarr.arpa"; answer = "192.168.1.179"; }
          { domain = "aria.arpa"; answer = "192.168.1.179"; }
          { domain = "jackett.arpa"; answer = "192.168.1.179"; }
          { domain = "bitwarden.arpa"; answer = "192.168.1.179"; }
          { domain = "prowlarr.arpa"; answer = "192.168.1.179"; }
          { domain = "adguard.arpa"; answer = "192.168.1.179"; }
          { domain = "cockpit.arpa"; answer = "192.168.1.179"; }
          { domain = "netdata.arpa"; answer = "192.168.1.179"; }
          { domain = "huginn.arpa"; answer = "192.168.1.179"; }
          { domain = "ntfy.arpa"; answer = "192.168.1.179"; }
          { domain = "kuma.arpa"; answer = "192.168.1.179"; }
          { domain = "plex.arpa"; answer = "192.168.1.179"; }
          { domain = "jellyseer.arpa"; answer = "192.168.1.179"; }
          { domain = "audiobooks.arpa"; answer = "192.168.1.179"; }
          { domain = "freshrss.arpa"; answer = "192.168.1.179"; }
          { domain = "filebrowser.arpa"; answer = "192.168.1.179"; }
          { domain = "photoprism.arpa"; answer = "192.168.1.179"; }
          { domain = "stash.arpa"; answer = "192.168.1.179"; }
          { domain = "bazarr.arpa"; answer = "192.168.1.179"; }
          { domain = "linkding.arpa"; answer = "192.168.1.179"; }
          { domain = "lidarr.arpa"; answer = "192.168.1.179"; }
          { domain = "openbooks.arpa"; answer = "192.168.1.179"; }
          { domain = "kavita.arpa"; answer = "192.168.1.179"; }
          { domain = "null.arpa"; answer = "192.168.1.179"; }
          { domain = "whisparr.arpa"; answer = "192.168.1.179"; }
          { domain = "readarr.arpa"; answer = "192.168.1.179"; }
          { domain = "metube.arpa"; answer = "192.168.1.179"; }
          { domain = "jellyfin.arpa"; answer = "192.168.1.179"; }
          { domain = "rpi4b.arpa"; answer = "192.168.1.152"; }
          { domain = "devstation.arpa"; answer = "192.168.1.249"; }
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
