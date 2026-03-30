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
        "attic_server_config_toml"
        "aws-secrets"
        "baikal_user_password"
        "cargo-token"
        "gh-token"
        "ghcr_ro_token"
        "hugging_face_token"
        "jira-token"
        "miniflux_app_password"
        "openai_api_key"
        "openweather-token"
        "pastebin-token"
        "phoenix_user_password"
        "radarr-api-key"
        "radicle_passphrase"
        "restic_backup_password"
        "sonarr-api-key"
        "taskwarrior_client_id"
        "taskwarrior_encryption_secret"
        "taskwarrior_env"
        "vpn-acc"
        "vpn-loc"
        "wallhaven-token"
      ];
}
