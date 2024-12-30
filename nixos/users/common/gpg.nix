{ pkgs, ... }:
{

  services.gpg-agent = {
    enable = false;
    pinentryPackage = pkgs.pinentry-curses;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
  };

  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    settings = {
      no-greeting = true;
      default-key = "54E80FA653BDD4DC6700A695B8C402B16E80E17C";
      pinentry-mode = "loopback";
      default-recipient-self = true;
      force-v3-sigs = true;
      escape-from-lines = true;
      lock-once = true;
      keyserver = "keys.openpgp.org";
    };
  };
}
