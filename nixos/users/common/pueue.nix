{ pkgs, ... }:
{
  home.packages = with pkgs; [ pueue ];
  services.pueue = {
    enable = true;
    settings = {
      daemon = {
        default_parallel_tasks = 4;
      };
    };
  };
}
