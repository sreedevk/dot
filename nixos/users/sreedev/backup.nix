{ pkgs, opts, username, ... }:
let
  sync-backups-archives =
    pkgs.writeShellScriptBin "sync-backups-archives" ''
      ${pkgs.rsync}/bin/rsync -aAXv --progress --delete --size-only /opt/backups/ nullptr.sh:/mnt/dpool0/backups/devstation/
    '';

  create-backup-archives =
    pkgs.writeShellScriptBin "create-backup-archives" ''
      ${pkgs.p7zip}/bin/7z a -t7z -m0=lzma2 -ms=on -mx=9 /opt/backups/data-notebook-archive-$(date +"%d-%m-%Y-%Z-%s" --utc).7z /home/${username}/Data/notebook
      ls -d /opt/backups/data-notebook-archive-*.7z --color=never | grep -v "$(ls -d /opt/backups/data-notebook-archive-*.7z --sort=time | head -n 1)" | xargs --no-run-if-empty rm

      ${pkgs.p7zip}/bin/7z a -t7z -m0=lzma2 -ms=on -mx=9 /opt/backups/data-work-archive-$(date +"%d-%m-%Y-%Z-%s" --utc).7z /home/${username}/Data/work
      ls -d /opt/backups/data-work-archive-*.7z --color=never | grep -v "$(ls -d /opt/backups/data-work-archive-*.7z --sort=time | head -n 1)" | xargs --no-run-if-empty rm

      ${pkgs.p7zip}/bin/7z a -t7z -m0=lzma2 -ms=on -mx=9 /opt/backups/data-thunderbird-archive-$(date +"%d-%m-%Y-%Z-%s" --utc).7z /home/${username}/.thunderbird
      ls -d /opt/backups/data-thunderbird-archive-*.7z --color=never | grep -v "$(ls -d /opt/backups/data-thunderbird-archive-*.7z --sort=time | head -n 1)" | xargs --no-run-if-empty rm
    '';

  sync-notes =
    pkgs.writeShellScriptBin "sync-notes" ''
      ${pkgs.rsync}/bin/rsync -aAXv --progress --delete --size-only /home/${username}/Data/notebook/ nullptr.sh:/mnt/dpool0/notes/notebook/
    '';
in
{
  home.packages = [ create-backup-archives sync-backups-archives sync-notes ];

  systemd.user = {
    services = {
      create-backup-archives = {
        Unit = { Description = "create backup archives"; };
        Service = {
          Type = "simple";
          ExecStart = "${create-backup-archives}/bin/create-backup-archives";
        };
      };

      sync-notes = {
        Unit = { Description = "sync notes"; };
        Service = {
          Type = "simple";
          ExecStart = "${sync-notes}/bin/sync-notes";
        };
      };

      sync-backups-archives = {
        Unit = { Description = "sync backup archives"; };
        Service = {
          Type = "simple";
          ExecStart = "${sync-backups-archives}/bin/sync-backups-archives";
        };
      };

    };

    timers = {

      sync-notes-timers = {
        Unit = {
          Description = "Timer for syncing backup archives";
        };
        Timer = {
          OnBootSec = "10m";
          OnUnitActiveSec = "1h";
          Unit = "sync-notes.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };

      sync-backups-archives-timers = {
        Unit = {
          Description = "Timer for syncing backup archives";
        };
        Timer = {
          OnBootSec = "4h";
          OnUnitActiveSec = "1w";
          Unit = "sync-backups-archives.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };

      create-backup-archives-timers = {
        Unit = {
          Description = "Timer for creating backup archives";
        };
        Timer = {
          OnBootSec = "4h";
          OnUnitActiveSec = "1d";
          Unit = "create-backup-archives.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
