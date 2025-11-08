{ inputs, ... }:
_: prev: {
  quickshell = inputs.quickshell.packages.${prev.stdenv.hostPlatform.system}.default;
  noctalia = inputs.noctalia.packages.${prev.stdenv.hostPlatform.system}.default;
}
