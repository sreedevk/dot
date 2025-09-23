{ ... }:
{
  
  age.secrets = {
    "aria2_env"                     = { file = ../../../secrets/aria2_env.age;                     };
    "authentik_env"                 = { file = ../../../secrets/authentik_env.age;                 };
    "autokuma_env"                  = { file = ../../../secrets/autokuma_env.age;                  };
    "aws-secrets"                   = { file = ../../../secrets/aws-secrets.age;                   };
    "baikal_user_password"          = { file = ../../../secrets/baikal_user_password.age;          };
    "bitmagnet_env"                 = { file = ../../../secrets/bitmagnet_env.age;                 };
    "cargo-token"                   = { file = ../../../secrets/cargo-token.age;                   };
    "container_registry_env"        = { file = ../../../secrets/container_registry_env.age;        };
    "dawarich_env"                  = { file = ../../../secrets/dawarich_env.age;                  };
    "digitalocean-token"            = { file = ../../../secrets/digitalocean-token.age;            };
    "fastmail_server_env"           = { file = ../../../secrets/fastmail_server_env.age;           };
    "firefly_env"                   = { file = ../../../secrets/firefly_env.age;                   };
    "gh-token"                      = { file = ../../../secrets/gh-token.age;                      };
    "ghcr_ro_token"                 = { file = ../../../secrets/ghcr_ro_token.age;                 };
    "gitea_env"                     = { file = ../../../secrets/gitea_env.age;                     };
    "gotify_env"                    = { file = ../../../secrets/gotify_env.age;                    };
    "hoarder_env"                   = { file = ../../../secrets/hoarder_env.age;                   };
    "hugging_face_token"            = { file = ../../../secrets/hugging_face_token.age;            };
    "jellystat_env"                 = { file = ../../../secrets/jellystat_env.age;                 };
    "jira-token"                    = { file = ../../../secrets/jira-token.age;                    };
    "k3s_token"                     = { file = ../../../secrets/k3s_token.age;                     };
    "livebook_env"                  = { file = ../../../secrets/livebook_env.age;                  };
    "miniflux_app_password"         = { file = ../../../secrets/miniflux_app_password.age;         };
    "miniflux_env"                  = { file = ../../../secrets/miniflux_env.age;                  };
    "minio_env"                     = { file = ../../../secrets/minio_env.age;                     };
    "n8n_env"                       = { file = ../../../secrets/n8n_env.age;                       };
    "nullptrderef1_admin_password"  = { file = ../../../secrets/nullptrderef1_admin_password.age;  };
    "openai_api_key"                = { file = ../../../secrets/openai_api_key.age;                };
    "openweather-token"             = { file = ../../../secrets/openweather-token.age;             };
    "paperless_env"                 = { file = ../../../secrets/paperless_env.age;                 };
    "pastebin-token"                = { file = ../../../secrets/pastebin-token.age;                };
    "photoprism_env"                = { file = ../../../secrets/photoprism_env.age;                };
    "pinepods_env"                  = { file = ../../../secrets/pinepods_env.age;                  };
    "podgrab_env"                   = { file = ../../../secrets/podgrab_env.age;                   };
    "radicle_passphrase"            = { file = ../../../secrets/radicle_passphrase.age;            };
    "restic_backup_password"        = { file = ../../../secrets/restic_backup_password.age;        };
    "romm_env"                      = { file = ../../../secrets/romm_env.age;                      };
    "tailscale_nginx_env"           = { file = ../../../secrets/tailscale_nginx_env.age;           };
    "taskwarrior_client_id"         = { file = ../../../secrets/taskwarrior_client_id.age;         };
    "taskwarrior_encryption_secret" = { file = ../../../secrets/taskwarrior_encryption_secret.age; };
    "taskwarrior_env"               = { file = ../../../secrets/taskwarrior_env.age;               };
    "tubearchivist_env"             = { file = ../../../secrets/tubearchivist_env.age;             };
    "vpn-acc"                       = { file = ../../../secrets/vpn-acc.age;                       };
    "vpn-loc"                       = { file = ../../../secrets/vpn-loc.age;                       };
    "wallhaven-token"               = { file = ../../../secrets/wallhaven-token.age;               };
    "watchtower_env"                = { file = ../../../secrets/watchtower_env.age;                };
    "wyl_env"                       = { file = ../../../secrets/wyl_env.age;                       };
    "paperless_gpt_env"             = { file = ../../../secrets/paperless_gpt_env.age;             };
  };
}
