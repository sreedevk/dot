{ pkgs, config, lib, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  programs.obs-studio = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.obs-studio "obs";
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      droidcam-obs
      waveform
    ];
  };
}
