let
  nyc0 = {
    "admin@apollo" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiYLIEBtoti0D2R5/nuGzXTQaYP7OynXMkAuJBeNit6";
    "deploy@devtechnica" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErdYvZ0RfDGze0QzHv8DCcc7Xt7rutKfOKRv44d0UiS";
    "pi@rpi4b" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
    "root@apollo" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyBIuu3f23/kGWoR8QQGfJitNDbff4qHH6qwFWCO6NG";
    "sreedev@phoenix" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILECZkgjRGtMkXHr44ytGrfpByPZbP2t5WeF6NgetYIO";
  };

  nyc1 = {
    "root@orion" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKB3TeebD9H4kDFcAobH2UTMHvVvnZSl3QHwmV7uVMnx";
    "u0@orion" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINmTKHR03AA/wBWcPdb5mlk4pplZ6tuZUdH6/qBvzKIS";
  };

  nyc0_secrets =
    with builtins;
    (foldl' (acc: elem: acc // { "secrets/nyc0/${elem}.age".publicKeys = attrValues nyc0; }) { } [
      "apollo_admin_password"
      "apollo_nginx_env"
      "arcane_agent_env"
      "arcane_env"
      "aria2_env"
      "attic_env"
      "attic_server_config_toml"
      "autobrr_env"
      "autokuma_env"
      "aws-secrets"
      "baikal_user_password"
      "bitmagnet_env"
      "cargo-token"
      "container_registry_env"
      "dawarich_env"
      "ddns_config_json"
      "digitalocean-token"
      "dumb_assets_env"
      "fastmail_server_env"
      "firefly_env"
      "gh-token"
      "ghcr_ro_token"
      "gitea_env"
      "gotify_env"
      "grimmory"
      "hugging_face_token"
      "invio_env"
      "jellystat_env"
      "jira-token"
      "k3s_token"
      "karakeep_env"
      "koito_env"
      "livebook_env"
      "miniflux_app_password"
      "miniflux_env"
      "minio_env"
      "moneroconf"
      "next_explorer_env"
      "nullptrderef1_admin_password"
      "openai_api_key"
      "openweather-token"
      "paperless_env"
      "paperless_gpt_env"
      "pastebin-token"
      "phoenix_user_password"
      "photoprism_env"
      "pinepods_env"
      "pocket_id_env"
      "podgrab_env"
      "pushtify_env"
      "radarr-api-key"
      "radicle_passphrase"
      "restic_backup_password"
      "romm_env"
      "rpi4b_pi_user_password"
      "searxng_env"
      "slskd_env"
      "sonarr-api-key"
      "stash_vr_env"
      "tailscale_nginx_env"
      "taskwarrior_client_id"
      "taskwarrior_encryption_secret"
      "taskwarrior_env"
      "tinyauth_env"
      "tududi_env"
      "vpn-acc"
      "vpn-loc"
      "wallhaven-token"
    ]);
  nyc1_secrets =
    with builtins;
    foldl' (acc: elem: acc // { "secrets/nyc1/${elem}.age".publicKeys = attrValues nyc1; }) { } [
      "orion_admin_password"
      "orion_nginx_env"
      "tailscale_nginx_env"
      "vpn-acc"
      "vpn-loc"
    ];
in
nyc0_secrets // nyc1_secrets
