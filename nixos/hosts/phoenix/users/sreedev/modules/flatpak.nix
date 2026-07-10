_: {
  xdg.dataFile."flatpak/overrides/org.jellyfin.JellyfinDesktop".text = ''
    [Context]
    devices=dri;

    [Environment]
    __NV_PRIME_RENDER_OFFLOAD=1
    __VK_LAYER_NV_optimus=NVIDIA_only
    __GLX_VENDOR_LIBRARY_NAME=nvidia
  '';
}
