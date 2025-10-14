{ inputs, ... }:
_: prev: {
  inherit (inputs.home-manager.packages.${prev.system}) home-manager;
}
