{ ... }:
{
  home.file = {
    ".config/rbw/config.json" = {
      text = builtins.toJSON {
        email = "srkod@odoo.com";
        sso_id = null;
        base_url = "https://api.bitwarden.com/";
        identity_url = "https://api.bitwarden.com/";
        ui_url = "https://vault.bitwarden.com/";
        notifications_url = "https://notifications.bitwarden.com/";
        lock_timeout = 3600;
        sync_interval = 3600;
        pinentry = "pinentry-curses";
        client_cert_path = null;
      };
    };
  };
}
