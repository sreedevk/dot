let

  nyc0 = {
    "root@apollo"        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyBIuu3f23/kGWoR8QQGfJitNDbff4qHH6qwFWCO6NG";
    "pi@rpi4b"           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
    "deploy@devtechnica" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErdYvZ0RfDGze0QzHv8DCcc7Xt7rutKfOKRv44d0UiS";
    "admin@apollo"       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiYLIEBtoti0D2R5/nuGzXTQaYP7OynXMkAuJBeNit6";
    "sreedev@devstation" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP";
  };

  nyc1 = {
    "root@farfalle"  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGbo3EcK+VeUo3b9qrAQzQH7dE99yevktzev31CL9btt";
    "admin@farfalle" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHPwQwv2XR3XFpS2JQYNLz3csxiCHsdxINIjHnt67NB";
  };

in
with builtins;
{

  # SEC nyc0

  "secrets/nyc0/apollo_admin_password.age".publicKeys         = attrValues nyc0;
  "secrets/nyc0/apollo_nginx_env.age".publicKeys              = attrValues nyc0;
  "secrets/nyc0/aria2_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/attic_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/attic_server_config_toml.age".publicKeys      = attrValues nyc0;
  "secrets/nyc0/authentik_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/autokuma_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/aws-secrets.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/baikal_user_password.age".publicKeys          = attrValues nyc0;
  "secrets/nyc0/bitmagnet_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/cargo-token.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/container_registry_env.age".publicKeys        = attrValues nyc0;
  "secrets/nyc0/dawarich_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/dumb_assets_env.age".publicKeys               = attrValues nyc0;
  "secrets/nyc0/fastmail_server_env.age".publicKeys           = attrValues nyc0;
  "secrets/nyc0/firefly_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/fireshare_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/gh-token.age".publicKeys                      = attrValues nyc0;
  "secrets/nyc0/ghcr_ro_token.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/gotify_env.age".publicKeys                    = attrValues nyc0;
  "secrets/nyc0/hoarder_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/hugging_face_token.age".publicKeys            = attrValues nyc0;
  "secrets/nyc0/jellystat_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/jira-token.age".publicKeys                    = attrValues nyc0;
  "secrets/nyc0/k3s_token.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/miniflux_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/minio_env.age".publicKeys                     = attrValues nyc0;
  "secrets/nyc0/n8n_env.age".publicKeys                       = attrValues nyc0;
  "secrets/nyc0/openai_api_key.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/openweather-token.age".publicKeys             = attrValues nyc0;
  "secrets/nyc0/paperless_env.age".publicKeys                 = attrValues nyc0;
  "secrets/nyc0/paperless_gpt_env.age".publicKeys             = attrValues nyc0;
  "secrets/nyc0/pastebin-token.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/photoprism_env.age".publicKeys                = attrValues nyc0;
  "secrets/nyc0/pinepods_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/podgrab_env.age".publicKeys                   = attrValues nyc0;
  "secrets/nyc0/radicle_passphrase.age".publicKeys            = attrValues nyc0;
  "secrets/nyc0/restic_backup_password.age".publicKeys        = attrValues nyc0;
  "secrets/nyc0/romm_env.age".publicKeys                      = attrValues nyc0;
  "secrets/nyc0/sonobarr_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/stash_vr_env.age".publicKeys                  = attrValues nyc0;
  "secrets/nyc0/tailscale_nginx_env.age".publicKeys           = attrValues nyc0;
  "secrets/nyc0/taskwarrior_client_id.age".publicKeys         = attrValues nyc0;
  "secrets/nyc0/taskwarrior_encryption_secret.age".publicKeys = attrValues nyc0;
  "secrets/nyc0/taskwarrior_env.age".publicKeys               = attrValues nyc0;
  "secrets/nyc0/vpn-acc.age".publicKeys                       = attrValues nyc0;
  "secrets/nyc0/vpn-loc.age".publicKeys                       = attrValues nyc0;
  "secrets/nyc0/wallhaven-token.age".publicKeys               = attrValues nyc0;
  "secrets/nyc0/watchtower_env.age".publicKeys                = attrValues nyc0;

  # SEC nyc1

  "secrets/nyc1/farfalle_admin_password.age".publicKeys       = attrValues nyc1;

}
