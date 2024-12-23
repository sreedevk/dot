{ age, username, ... }:
{
  age.secrets = {
    "vpn-acc" = { file = ./vpn-acc.age; };
    "vpn-loc" = { file = ./vpn-loc.age; };
    "jira-token" = { file = ./jira-token.age; };
    "cargo-token" = { file = ./cargo-token.age; };
    "digitalocean-token" = { file = ./digitalocean-token.age; };
    "openweather-token" = { file = ./openweather-token.age; };
    "pastebin-token" = { file = ./pastebin-token.age; };
    "wallhaven-token" = { file = ./wallhaven-token.age; };
    "gh-token" = { file = ./gh-token.age; };
    "aws-secrets" = { file = ./aws-secrets.age; };
    "nullptrderef1_admin_password" = { file = ./nullptrderef1_admin_password.age; };
    "spotify_client_id" = { file = ./spotify_client_id.age; };
    "spotify_client_secret" = { file = ./spotify_client_secret.age; };
    "taskwarrior_client_id" = { file = ./taskwarrior_client_id.age; };
    "taskwarrior_encryption_secret" = { file = ./taskwarrior_encryption_secret.age; };
    "k3s_token" = { file = ./k3s_token.age; };
    "bw_session" = { file = ./bw_session.age; };
    "hugging_face_token" = { file = ./hugging_face_token.age; };
    "openai_api_key" = { file = ./openai_api_key.age; };
  };
}
