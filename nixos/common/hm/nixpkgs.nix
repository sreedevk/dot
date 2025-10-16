{ inputs, ... }:
{
  nixpkgs = {
    overlays = import ../overlays { inherit inputs; };
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowBroken = true;
    };
  };
}
