{ inputs, ... }:
[
  (import ./agenix.nix { inherit inputs; })
  (import ./stable.nix { inherit inputs; })
  inputs.nixgl.overlay
  inputs.nur.overlays.default
]
