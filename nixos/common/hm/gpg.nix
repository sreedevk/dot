{ pkgs, opts, ... }:
{

  # will conflict with services.gpg-agent config, so please disable when using services.gpg-agent
  home.file = {
    ".gnupg/gpg-agent.conf" = {
      enable = true;
      text = ''
        pinentry-program /usr/bin/pinentry-curses
        default-cache-ttl 86400
        max-cache-ttl 86400
        allow-loopback-pinentry
        allow-preset-passphrase
      '';
    };
  };

  services.gpg-agent = {
    enable = false;
    pinentry.package = pkgs.pinentry-curses;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
    extraConfig = ''
      allow-loopback-pinentry
      allow-preset-passphrase
    '';
  };

  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    settings = {
      no-greeting = true;
      default-key = opts.gpg-key-signature;
      pinentry-mode = "loopback";
      default-recipient-self = true;
      force-v3-sigs = true;
      escape-from-lines = true;
      lock-once = true;
      keyserver = "keys.openpgp.org";
    };
  };
}
