{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  programs.obs-studio = {
    enable = true;
    package = (nixglmod.nixGLWrapped pkgs.obs-studio "obs");
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      waveform
      wlrobs
    ];
  };
}
