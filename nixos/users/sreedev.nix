{ pkgs, secrets, lib, inputs, system, username, ... }: {
  imports = [
    ./common/autorandr.nix
    ./common/dunst.nix
    ./common/firefox.nix
    ./common/misc.nix
    ./common/packages/cli.nix
    ./common/packages/gui.nix
    ./common/ssh.nix
    ./common/stylix.nix
    ./common/systemd.nix
    ./common/taskwarrior.nix
    ./common/zsh.nix
  ];

  fonts.fontconfig = {
    enable = lib.mkForce true;
    defaultFonts = {
      monospace = [ "Iosevka NF" ];
      serif = [ "Iosevka NF" ];
      sansSerif = [ "Iosevka NF" ];
    };
  };

  systemd.user.services = {
    autotiling = {
      Unit = {
        Description = "xorg based window manager autotiling service";
        Documentation = "https://github.com/nwg-piotr/autotiling";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.autotiling}/bin/autotiling";
        Restart = "always";
        RestartSec = 3;
        StartLimitInterval = 0;
        StartLimitBurst = 0;
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };

  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = secrets.aws.config.region;
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = secrets.aws.credentials.aws_access_key_id;
        "aws_secret_access_key" = secrets.aws.credentials.aws_secret_access_key;
      };
    };
  };

  programs.zsh.enable = true;
}
