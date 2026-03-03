{ pkgs, config, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      waveform
      wlrobs
    ];
  };
}
