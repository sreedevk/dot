_: {
  age.secrets = {
    "aws-secrets"                   = { file = ../../../secrets/nyc0/aws-secrets.age;                   };
    "baikal_user_password"          = { file = ../../../secrets/nyc0/baikal_user_password.age;          };
    "cargo-token"                   = { file = ../../../secrets/nyc0/cargo-token.age;                   };
    "gh-token"                      = { file = ../../../secrets/nyc0/gh-token.age;                      };
    "ghcr_ro_token"                 = { file = ../../../secrets/nyc0/ghcr_ro_token.age;                 };
    "hugging_face_token"            = { file = ../../../secrets/nyc0/hugging_face_token.age;            };
    "jira-token"                    = { file = ../../../secrets/nyc0/jira-token.age;                    };
    "miniflux_app_password"         = { file = ../../../secrets/nyc0/miniflux_app_password.age;         };
    "openai_api_key"                = { file = ../../../secrets/nyc0/openai_api_key.age;                };
    "openweather-token"             = { file = ../../../secrets/nyc0/openweather-token.age;             };
    "pastebin-token"                = { file = ../../../secrets/nyc0/pastebin-token.age;                };
    "radicle_passphrase"            = { file = ../../../secrets/nyc0/radicle_passphrase.age;            };
    "restic_backup_password"        = { file = ../../../secrets/nyc0/restic_backup_password.age;        };
    "taskwarrior_client_id"         = { file = ../../../secrets/nyc0/taskwarrior_client_id.age;         };
    "taskwarrior_encryption_secret" = { file = ../../../secrets/nyc0/taskwarrior_encryption_secret.age; };
    "taskwarrior_env"               = { file = ../../../secrets/nyc0/taskwarrior_env.age;               };
    "vpn-acc"                       = { file = ../../../secrets/nyc0/vpn-acc.age;                       };
    "vpn-loc"                       = { file = ../../../secrets/nyc0/vpn-loc.age;                       };
    "wallhaven-token"               = { file = ../../../secrets/nyc0/wallhaven-token.age;               };
  };
}
