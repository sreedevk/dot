{ inputs, ... }:
_: prev: {
  agenix = inputs.agenix.packages.${prev.stdenv.hostPlatform.system}.default;
}
