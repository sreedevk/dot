{ pkgs, secrets, ... }:
{
  programs.irssi = {
    enable = true;
    extraConfig = ''
      settings = {
        core = { 
          real_name = "sreedev";
          user_name = "sreedev";
          nick = "sreedev";
        };
      };
      chatnets = {
        LiberaChat = {
          type = "IRC";
          sasl_mechanism = "PLAIN";
          sasl_username = "sreedev";
          sasl_password = ${secrets.irssi_liberachat_password};
        };
      };
      servers = (
        {
          address = "irc.libera.chat";
          chatnet = "LiberaChat";
          port = "6697";
          use_tls = "yes";
          tls_verify = "yes";
          autoconnect = "yes";
        };
      );
    '';
  };
}
