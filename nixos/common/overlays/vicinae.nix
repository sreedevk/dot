{ inputs, ... }:
_: prev: {
  vicinae = inputs.vicinae.packages.${prev.stdenv.hostPlatform.system}.default;
}
