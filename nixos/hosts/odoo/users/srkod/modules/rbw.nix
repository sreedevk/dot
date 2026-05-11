{ ... }:
{
  home.file = {
    ".config/rbw/config.json" = {
      text = builtins.toJSON {
        email = "srkod@odoo.com";
        lock_timeout = 3600;
        sync_interval = 3600;
        pinentry = "pinentry-curses";
      };
    };
  };
}
