{ pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
        padding = {
          top = 0;
          left = 2;
        };
      };
      display = {
        size.binaryPrefix = "si";
        color = "blue";
        separator = "   ";
      };
      modules = [
        "Break"
        {
          type = "kernel";
          key = "  KERN";
          format = "{1} {2}";
        }
        {
          type = "cpu";
          key = "  CPU ";
          format = "{1}";
        }
        {
          "type" = "terminal";
          "key" = "  TERM";
          "format" = "{5}";
        }
        {
          type = "memory";
          key = "  MEM ";
          format = "{1} / {2} ({3})";
        }
        {
          type = "Disk";
          key = "🖴  DISK";
        }
        "Break"
        {
          type = "colors";
          paddingLeft = 12;
          symbol = "circle";
        }
      ];
    };
  };
}
