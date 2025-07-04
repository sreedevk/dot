{ pkgs, opts, ... }:
let
  wallpaper = "${opts.directories.wallpapers}/${opts.desktop.wallpaper}";
  setwall = wall: ''
    ${pkgs.swww}/bin/swww img --transition-type wipe --transition-fps 60 --resize stretch --transition-step 60 --transition-duration 2 "${wall}"
  '';
in
{
  home.packages = with pkgs; [ swww ];
  services.swww.enable = true;
  systemd.user.services = {
    swww-set-wallpaper = {
      Unit = {
        Description = "Initialize swww wallpaper";
        Documentation = "info:swww man:swww(1) https://github.com/LGFae/swww";
        After = [ "swww.service" ];
        BindsTo = [ "swww.service" ];
        Requires = [ "swww.service" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = setwall wallpaper;
        Restart = "on-failure";
        RestartSec = 1;
      };
      Install = {
        WantedBy = [ "swww.service" ];
      };
    };
  };
}
