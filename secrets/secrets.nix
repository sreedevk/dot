let
  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDaBQM6gItlkowGwo+xC70FX7egJxcLABZhWVDKzKUOC" # root@nullptrderef1
  ];

  users = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP" # sreedev@devstation
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErdYvZ0RfDGze0QzHv8DCcc7Xt7rutKfOKRv44d0UiS" # deploy@devtechnica
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV" # pi@rpi4b
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2pNg6tFrSaQ+oTlGAhboBgQQ+I7S3sXoyM1DfOsI0f" # admin@nullptrderef1
  ];

  keys = users ++ systems;
in
{
  "vpn-acc.age".publicKeys = keys;
  "vpn-loc.age".publicKeys = keys;
  "jira-token.age".publicKeys = keys;
  "cargo-token.age".publicKeys = keys;
  "digitalocean-token.age".publicKeys = keys;
  "openweather-token.age".publicKeys = keys;
  "pastebin-token.age".publicKeys = keys;
  "wallhaven-token.age".publicKeys = keys;
  "gh-token.age".publicKeys = keys;
  "aws-secrets.age".publicKeys = keys;
  "nullptrderef1_admin_password.age".publicKeys = keys;
  "spotify_client_id.age".publicKeys = keys;
  "spotify_client_secret.age".publicKeys = keys;
  "taskwarrior_client_id.age".publicKeys = keys;
  "taskwarrior_encryption_secret.age".publicKeys = keys;
  "k3s_token.age".publicKeys = keys;
  "bw_session.age".publicKeys = keys;
  "hugging_face_token.age".publicKeys = keys;
  "miniflux_app_password.age".publicKeys = keys;
  "openai_api_key.age".publicKeys = keys;
}
