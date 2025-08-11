{ opts, ... }:
rec {
  supervisorctl = {
    server = {
      type = "unix"; # or http
      url =
        if supervisorctl.server.type == "unix"
        then unix_http_server.file
        else "${inet_http_server.ip_addr}:${inet_http_server.port}";
    };
    auth =
      if supervisorctl.server.type == "unix"
      then unix_http_server.auth
      else inet_http_server.auth;
  };
  unix_http_server = {
    file = "/tmp/supervisor.sock";
    chmod = "0700";
    auth = {
      enabled = false;
      inherit (opts) username;
      password = "changeme";
    };
  };
  inet_http_server = {
    enable = false;
    ip_addr = "0.0.0.0";
    port = opts.ports.supervisord;
    auth = {
      enabled = false;
      inherit (opts) username;
      password = "changeme";
    };
  };

  generated = {
    unix_http_server_config =
      ''
        [unix_http_server]
        file=${unix_http_server.file or "/tmp/supervisor.sock"}
        chmod=${unix_http_server.chmod or "0700"}
        chown=${opts.adminUID}:${opts.adminGID}
        ${ if unix_http_server.auth.enabled then "username=${unix_http_server.auth.username}" else "" }
        ${ if unix_http_server.auth.enabled then "password=${unix_http_server.auth.password}" else "" }
      '';
    inet_http_server_config =
      if !inet_http_server.enable then "" else
      ''
        [inet_http_server]
        port=${inet_http_server.ip_addr}:${inet_http_server.port}
        ${ if inet_http_server.auth.enabled then "username=${inet_http_server.auth.username}" else "" }
        ${ if inet_http_server.auth.enabled then "username=${inet_http_server.auth.password}" else "" }
      '';
    supervisorctl_config =
      ''
        [supervisorctl]
        serverurl=${supervisorctl.server.type}://${supervisorctl.server.url}
        ${ if supervisorctl.auth.enabled then "username=${supervisorctl.auth.username}" else "" }
        ${ if supervisorctl.auth.enabled then "username=${supervisorctl.auth.password}" else "" }
        prompt=${opts.hostname}-supervisorctl
        ; history_file = ~/.sc_history
      '';
  };
}
