{ username, ... }:
{
  age = {
    identityPaths = [
      "/home/${username}/.ssh/id_ed25519"
    ];
    secretsDir = "/home/${username}/.agenix/agenix";
    secretsMountPoint = "/home/${username}/.agenix/agenix.d";
  };
}
