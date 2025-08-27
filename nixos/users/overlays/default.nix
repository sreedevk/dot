{ inputs, ... }:
[
  (import ./agenix.nix { inherit inputs; })
  (import ./lmms.nix { inherit inputs; })
  (import ./quickshell.nix { inherit inputs; })
  inputs.nixgl.overlay
  inputs.nur.overlays.default
]
