{ pkgs, secrets, ... }: {
  home.file = {
    ".taskrc" = {
      enable = true;
      text = ''
        # Color theme (uncomment one to use)
        # include dark-16.theme
        # include dark-256.theme
        # include dark-blue-256.theme
        # include dark-gray-256.theme
        # include dark-gray-blue-256.theme
        # include dark-green-256.theme
        # include dark-red-256.theme
        # include dark-yellow-green.theme
        # include light-16.theme
        # include light-256.theme
        # include no-color.theme
        include solarized-dark-256.theme
        # include solarized-light-256.theme
        # include dark-violets-256.theme
        data.location=~/.task/
        hooks.location=~/.task/hooks
        sync.server.origin=http://nullptrderef1:8080
        sync.server.client_id=${secrets.taskwarrior.client_id}
        sync.encryption_secret=${secrets.taskwarrior.encryption_secret}
      '';
      recursive = false;
    };
  };
}
