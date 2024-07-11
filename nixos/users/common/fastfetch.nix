{ pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
      };
      display = {
        binaryPrefix = "si";
        color = "blue";
        separator = "   ";
      };
      modules = [
        "title"
        "separator"
        {
          type = "datetime";
          key = "TimeStamp";
          format = "{1}-{3}-{11} {14}:{17}:{20}";
        }
        "Host"
        "Chassis"
        "Bios"
        "Board"
        "OS"
        "Kernel"
        "Uptime"
        "LocalIp"
        "CPU"
        "GPU"
        "Memory"
        "Disk"
        "Break"
        "Colors"
      ];
    };
  };
}
