{ opts, ... }:
_: prev: {
  nixgl = prev.nixgl.override {
    inherit (opts) nvidiaVersion;
    nvidiaURL = "https://us.download.nvidia.com/XFree86/Linux-x86_64";
  };
}
