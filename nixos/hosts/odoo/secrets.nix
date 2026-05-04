_: with builtins; {
  age.secrets =
    foldl'
      (
        acc: elem:
        acc
        // {
          "${elem}" = {
            file = ../../../secrets/nyc0/${elem}.age;
          };
        }
      )
      { }
      [
        # "gh-token"
        # "ghcr_ro_token"
        # "openai_api_key"
        # "openweather-token"
        # "radarr-api-key"
        # "radicle_passphrase"
        # "restic_backup_password"
        # "taskwarrior_client_id"
        # "taskwarrior_encryption_secret"
        # "vpn-acc"
        # "vpn-loc"
        # "wallhaven-token"
      ];
}
