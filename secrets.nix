let
  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDaBQM6gItlkowGwo+xC70FX7egJxcLABZhWVDKzKUOC" # root@nullptrderef1
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyBIuu3f23/kGWoR8QQGfJitNDbff4qHH6qwFWCO6NG" # root@apollo
  ];

  users = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV" # pi@rpi4b
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErdYvZ0RfDGze0QzHv8DCcc7Xt7rutKfOKRv44d0UiS" # deploy@devtechnica
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiYLIEBtoti0D2R5/nuGzXTQaYP7OynXMkAuJBeNit6" # admin@apollo
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP" # sreedev@devstation
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2pNg6tFrSaQ+oTlGAhboBgQQ+I7S3sXoyM1DfOsI0f" # admin@nullptrderef1
  ];

  keys = users ++ systems;
in
{
  "secrets/apollo_admin_password.age".publicKeys         = keys;
  "secrets/apollo_nginx_env.age".publicKeys              = keys;
  "secrets/aria2_env.age".publicKeys                     = keys;
  "secrets/attic_env.age".publicKeys                     = keys;
  "secrets/attic_server_config_toml.age".publicKeys      = keys;
  "secrets/authentik_env.age".publicKeys                 = keys;
  "secrets/autokuma_env.age".publicKeys                  = keys;
  "secrets/aws-secrets.age".publicKeys                   = keys;
  "secrets/baikal_user_password.age".publicKeys          = keys;
  "secrets/bitmagnet_env.age".publicKeys                 = keys;
  "secrets/cargo-token.age".publicKeys                   = keys;
  "secrets/container_registry_env.age".publicKeys        = keys;
  "secrets/dawarich_env.age".publicKeys                  = keys;
  "secrets/digitalocean-token.age".publicKeys            = keys;
  "secrets/fastmail_server_env.age".publicKeys           = keys;
  "secrets/firefly_env.age".publicKeys                   = keys;
  "secrets/gh-token.age".publicKeys                      = keys;
  "secrets/ghcr_ro_token.age".publicKeys                 = keys;
  "secrets/gotify_env.age".publicKeys                    = keys;
  "secrets/hoarder_env.age".publicKeys                   = keys;
  "secrets/hugging_face_token.age".publicKeys            = keys;
  "secrets/jellystat_env.age".publicKeys                 = keys;
  "secrets/jira-token.age".publicKeys                    = keys;
  "secrets/k3s_token.age".publicKeys                     = keys;
  "secrets/miniflux_env.age".publicKeys                  = keys;
  "secrets/minio_env.age".publicKeys                     = keys;
  "secrets/nullptrderef1_admin_password.age".publicKeys  = keys;
  "secrets/openai_api_key.age".publicKeys                = keys;
  "secrets/openweather-token.age".publicKeys             = keys;
  "secrets/paperless_env.age".publicKeys                 = keys;
  "secrets/paperless_gpt_env.age".publicKeys             = keys;
  "secrets/pastebin-token.age".publicKeys                = keys;
  "secrets/photoprism_env.age".publicKeys                = keys;
  "secrets/pinepods_env.age".publicKeys                  = keys;
  "secrets/podgrab_env.age".publicKeys                   = keys;
  "secrets/radicle_passphrase.age".publicKeys            = keys;
  "secrets/restic_backup_password.age".publicKeys        = keys;
  "secrets/romm_env.age".publicKeys                      = keys;
  "secrets/tailscale_nginx_env.age".publicKeys           = keys;
  "secrets/taskwarrior_client_id.age".publicKeys         = keys;
  "secrets/taskwarrior_encryption_secret.age".publicKeys = keys;
  "secrets/taskwarrior_env.age".publicKeys               = keys;
  "secrets/vpn-acc.age".publicKeys                       = keys;
  "secrets/vpn-loc.age".publicKeys                       = keys;
  "secrets/wallhaven-token.age".publicKeys               = keys;
  "secrets/watchtower_env.age".publicKeys                = keys;
}
