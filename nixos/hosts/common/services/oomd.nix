{ ... }:
{
  systemd.oomd = {
    enable = true;
    enableSystemSlice = true;
    enableRootSlice = false;
    enableUserSlices = true;
    extraConfig = {
      DefaultMemoryPressureDurationSec = "30s";
      DefaultMemoryPressureLimit = "60%";
      SwapUsedLimit = "90%";
    };
  };
}
