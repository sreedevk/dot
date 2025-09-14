{ ... }:
final: prev: {
  nixgl = prev.nixgl.override {
    nvidiaUrl = "https://us.download.nvidia.com/XFree86/Linux-x86_64";
  };
}
