{ inputs, ... }:
final: prev: {
  jellyfin-desktop = prev.jellyfin-desktop.overrideAttrs (old: {
    qtWrapperArgs = (old.qtWrapperArgs or [ ]) ++ [
      "--set QT_QPA_PLATFORM xcb"
      "--set __GLX_VENDOR_LIBRARY_NAME nvidia"
      "--set QT_XCB_GL_INTEGRATION glx"
    ];
  });
}
