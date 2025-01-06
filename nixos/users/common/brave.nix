{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  home.packages = [
    (nixglmod.nixGLWrapped pkgs.brave "brave")
  ];

  home.file = {
    ".config/brave-flags.conf" = {
      enable = true;
      # --disable-features=Vulkan,UseChromeOSDirectVideoDecoder 
      text = ''
        --disable-gpu-memory-buffer-video-frames
        --ozone-platform=wayland
        --ozone-platform-hint=auto
        --enable-features=WebRTCPipeWireCapturer,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks
        --ignore-gpu-blocklist
        --enable-gpu-rasterization
        --enable-zero-copy
      '';
    };
  };
}
