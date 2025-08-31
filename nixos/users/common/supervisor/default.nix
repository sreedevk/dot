{ pkgs, opts, ... }:
let
  supervisor_opts = import ./opts.nix { inherit opts; };
  supervisord = pkgs.writeShellScriptBin "supervisord" ''
    ${pkgs.python312Packages.supervisor}/bin/supervisord -c $HOME/.config/supervisor/supervisor.conf $@
  '';

  supervisorctl = pkgs.writeShellScriptBin "supervisorctl" ''
    ${pkgs.python312Packages.supervisor}/bin/supervisorctl -c $HOME/.config/supervisor/supervisor.conf $@
  '';
in
{
  home.packages = [
    supervisord
    supervisorctl
  ];

  imports = [ ./programs ];

  # http://supervisord.org/configuration.html
  home.file = {
    ".config/supervisor/supervisor.conf" = {
      text = ''
        ${supervisor_opts.generated.unix_http_server_config}

        ${supervisor_opts.generated.inet_http_server_config}

        [supervisord]
        logfile=/tmp/supervisord.log ; main log file; default $CWD/supervisord.log
        logfile_maxbytes=50MB        ; max main logfile bytes b4 rotation; default 50MB
        logfile_backups=10           ; # of main logfile backups; 0 means none, default 10
        loglevel=info                ; log level; default info; others: debug,warn,trace
        pidfile=/tmp/supervisord.pid ; supervisord pidfile; default supervisord.pid
        nodaemon=false               ; start in foreground if true; default false
        silent=false                 ; no logs to stdout if true; default false
        minfds=1024                  ; min. avail startup file descriptors; default 1024
        minprocs=200                 ; min. avail process descriptors;default 200
        ;umask=022                   ; process file creation umask; default 022
        ;user=supervisord            ; setuid to this UNIX account at startup; recommended if root
        ;identifier=supervisor       ; supervisord identifier, default is 'supervisor'
        ;directory=/tmp              ; default is not to cd during start
        ;nocleanup=true              ; don't clean up tempfiles at start; default false
        ;childlogdir=/tmp            ; 'AUTO' child log dir, default $TEMP
        ;environment=KEY="value"     ; key value pairs to add to environment
        ;strip_ansi=false            ; strip ansi escape codes in logs; def. false

        ${supervisor_opts.generated.supervisorctl_config}

        [rpcinterface:supervisor]
        supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

        [include]
        files = programs/*.ini
      '';
    };
  };
}
