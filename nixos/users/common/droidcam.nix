{ pkgs, ... }:
let
  droidcam-connect = pkgs.writeShellScriptBin "dc-connect" ''
    /usr/bin/tailscale status | grep devcomm | awk '{print $1}' | xargs -Ix /usr/bin/droidcam-cli x 4747
  '';
in
{
  systemd.user =
    {
      services = {
        droidcam = {
          Unit = {
            Description = "Droidcam User Service";
            Documentation = "https://github.com/dev47apps/droidcam-linux-client";
          };
          Service = {
            Type = "simple";
            ExecStart = "${droidcam-connect}/bin/dc-connect";
          };
        };
      };
    };
}

