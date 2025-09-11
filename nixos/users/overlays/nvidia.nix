{ inputs, ... }:
final: prev: {
  nixgl = prev.nixgl.overrideAttrs (oldAttrs: {
    nvidiaDriverSrc = final.fetchurl {
      url = "https://us.download.nvidia.com/XFree86/Linux-x86_64/580.82.09/NVIDIA-Linux-x86_64-580.82.09.run";
      sha256 = "1dwmardvxb2w6mx7hich5wc06f50qz92jk63kbhf059fv8rgiv1y";
    };
  });
}
