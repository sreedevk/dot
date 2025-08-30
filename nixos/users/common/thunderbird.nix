{ pkgs, config, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.thunderbird;
    profiles = {
      "default" = {
        isDefault = false;
        withExternalGnupg = true;
      };
    };
  };

  accounts = {
    calendar = {
      accounts = {
        baikal = {
          remote = {
            type = "caldav";
            passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password cal.devtechnica.com";
            url = "https://cal.devtechnica.com/dav.php/calendars/sreedev/default";
            userName = "sreedev";
          };
        };
      };
    };

    email = {
      accounts = {
        icloud = {
          address = "sreedev@icloud.com";
          flavor = "plain";
          realName = "Sreedev Kodichath";
          userName = "sreedev@icloud.com";
          primary = false;
          passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password appleid.apple.com";
          smtp = {
            host = "smtp.mail.me.com";
            port = 587;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          thunderbird = {
            enable = true;
            profiles = [ "default" ];
          };
          imap = {
            host = "imap.mail.me.com";
            port = 993;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          gpg = {
            key = "54E80FA653BDD4DC6700A695B8C402B16E80E17C";
            signByDefault = true;
          };
        };
        fastmail = {
          address = "sreedev@devtechnica.com";
          flavor = "fastmail.com";
          realName = "Sreedev Kodichath";
          userName = "sreedev@devtechnica.com";
          primary = true;
          smtp = {
            host = "smtp.fastmail.com";
            port = 587;
            tls = {
              enable = true;
              useStartTls = true;
            };
          };
          passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password app.fastmail.com";
          thunderbird = {
            enable = true;
            profiles = [ "default" ];
          };
          imap = {
            host = "imap.fastmail.com";
            port = 993;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          gpg = {
            key = "AA7E38B4C9B32D7218F91A13E659F626A93FB93D";
            signByDefault = true;
          };
        };
      };
    };
  };
}
