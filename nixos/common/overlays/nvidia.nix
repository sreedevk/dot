_:
_: prev: {
  nixgl = prev.nixgl.override {
    nvidiaURL = "https://us.download.nvidia.com/XFree86/Linux-x86_64";
    nvidiaVersion = "590.48.01";
  };
}
