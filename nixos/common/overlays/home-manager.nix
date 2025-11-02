{ inputs, ... }:
_: prev: {
  inherit (inputs.home-manager.packages.${prev.stdenv.hostPlatform.system}) home-manager;
}
