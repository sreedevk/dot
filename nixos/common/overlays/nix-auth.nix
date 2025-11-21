{ inputs, ... }:
_: prev: {
  nix-auth = inputs.nix-auth.packages.${prev.stdenv.hostPlatform.system}.default;
}
