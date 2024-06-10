{ pkgs, secrets, ... }:
{
  systemd.user = {
    enable = true;
    services = {
      autotiling = {
        Unit = {
          Description = "xorg based window manager autotiling service";
          Documentation = "https://github.com/nwg-piotr/autotiling";
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.autotiling}/bin/autotiling";
          Restart = "on-failure";
          RestartSec = 3;
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
      emacs = {
        Unit = {
          Description = "Emacs text editor";
          Documentation = "info:emacs man:emacs(1) https://gnu.org/software/emacs/";
        };
        Service = {
          Type = "forking";
          ExecStart = "/usr/bin/emacs --daemon";
          ExecStop = "/usr/bin/emacsclient --eval \"(kill-emacs)\"";
          Environment = "SSH_AUTH_SOCK=%t/keyring/ssh";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
