let

  nyc0 = {
    "admin@apollo"       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiYLIEBtoti0D2R5/nuGzXTQaYP7OynXMkAuJBeNit6";
    "deploy@devtechnica" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErdYvZ0RfDGze0QzHv8DCcc7Xt7rutKfOKRv44d0UiS";
    "pi@rpi4b"           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
    "root@apollo"        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyBIuu3f23/kGWoR8QQGfJitNDbff4qHH6qwFWCO6NG";
    "sreedev@phoenix"    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILECZkgjRGtMkXHr44ytGrfpByPZbP2t5WeF6NgetYIO";
  };
in
with builtins;
{

  "secrets/nyc0/apollo_admin_password.age".publicKeys         = attrValues nyc0;
  "secrets/nyc0/apollo_nginx_env.age".publicKeys              = attrValues nyc0;
  "secrets/nyc0/arcane_agent_env.age".publicKeys              = attrValues nyc0;
  "secrets/nyc0/arcane_env.age".publicKeys                    = attrValues nyc0;
  "secrets/nyc0/aria2_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/attic_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/attic_server_config_toml.age".publicKeys      = attrValues nyc0;
  "secrets/nyc0/authentik_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/autobrr_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/autokuma_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/aws-secrets.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/baikal_user_password.age".publicKeys          = attrValues nyc0;
  "secrets/nyc0/bitmagnet_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/booklore_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/cargo-token.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/container_registry_env.age".publicKeys        = attrValues nyc0;
  "secrets/nyc0/dawarich_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/digitalocean-token.age".publicKeys            = attrValues nyc0;
  "secrets/nyc0/dumb_assets_env.age".publicKeys               = attrValues nyc0;
  "secrets/nyc0/fastmail_server_env.age".publicKeys           = attrValues nyc0;
  "secrets/nyc0/firefly_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/gh-token.age".publicKeys                      = attrValues nyc0;
  "secrets/nyc0/ghcr_ro_token.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/gitea_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/gotify_env.age".publicKeys                    = attrValues nyc0;
  "secrets/nyc0/hoarder_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/hugging_face_token.age".publicKeys            = attrValues nyc0;
  "secrets/nyc0/invio_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/jellystat_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/jira-token.age".publicKeys                    = attrValues nyc0;
  "secrets/nyc0/k3s_token.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/koito_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/livebook_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/miniflux_app_password.age".publicKeys         = attrValues nyc0;
  "secrets/nyc0/miniflux_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/minio_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/moneroconf.age".publicKeys                    = attrValues nyc0;
  "secrets/nyc0/n8n_env.age".publicKeys                       = attrValues nyc0;
  "secrets/nyc0/next_explorer_env.age".publicKeys             = attrValues nyc0;
  "secrets/nyc0/nullptrderef1_admin_password.age".publicKeys  = attrValues nyc0;
  "secrets/nyc0/openai_api_key.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/openweather-token.age".publicKeys             = attrValues nyc0;
  "secrets/nyc0/paperless_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/paperless_gpt_env.age".publicKeys             = attrValues nyc0;
  "secrets/nyc0/pastebin-token.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/phoenix_user_password.age".publicKeys         = attrValues nyc0;
  "secrets/nyc0/photoprism_env.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/pinepods_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/podgrab_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/pushtify_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/radarr-api-key.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/radicle_passphrase.age".publicKeys            = attrValues nyc0;
  "secrets/nyc0/restic_backup_password.age".publicKeys        = attrValues nyc0;
  "secrets/nyc0/romm_env.age".publicKeys                      = attrValues nyc0;
  "secrets/nyc0/rpi4b_pi_user_password.age".publicKeys        = attrValues nyc0;
  "secrets/nyc0/searxng_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/slskd_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/sonarr-api-key.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/sonobarr_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/stash_vr_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/tailscale_nginx_env.age".publicKeys           = attrValues nyc0;
  "secrets/nyc0/taskwarrior_client_id.age".publicKeys         = attrValues nyc0;
  "secrets/nyc0/taskwarrior_encryption_secret.age".publicKeys = attrValues nyc0;
  "secrets/nyc0/taskwarrior_env.age".publicKeys               = attrValues nyc0;
  "secrets/nyc0/vpn-acc.age".publicKeys                       = attrValues nyc0;
  "secrets/nyc0/vpn-loc.age".publicKeys                       = attrValues nyc0;
  "secrets/nyc0/wallhaven-token.age".publicKeys               = attrValues nyc0;
  # SEC nyc0
}
