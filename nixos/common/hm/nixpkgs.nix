{ inputs, opts, ... }:
{
  nixpkgs = {
    overlays = import ../overlays { inherit inputs opts; };
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowBroken = true;
    };
  };
}
