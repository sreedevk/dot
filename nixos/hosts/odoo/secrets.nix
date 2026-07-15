_: with builtins; {
  age.secrets =
    foldl'
      (
        acc: elem:
        acc
        // {
          "${elem}" = {
            file = ../../../secrets/odoo/${elem}.age;
          };
        }
      )
      { }
      [
        "gh_token"
        "ghcr_ro_token"
        "noctalia_state_toml"
        "restic_backup_password"
        "taskwarrior_client_id"
        "taskwarrior_encryption_secret"
      ];
}
