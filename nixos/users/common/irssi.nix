{ pkgs, secrets, ... }:
{
  programs.irssi = {
    enable = true;
    extraConfig = ''
      servers = (
        {
          address = "irc.libera.chat";
          chatnet = "liberachat";
          port = "6697";
          use_tls = "yes";
          tls_cert = "~/.irssi/certs/libera.pem";
          tls_verify = "yes";
        },
        {
          address = "irc.libera.chat:6697";
          chatnet = "liberachat";
          port = "6667";
          use_tls = "yes";
          tls_cert = "~/.irssi/certs/libera.pem";
          tls_verify = "yes";
        }
      );
      chatnets = {
        liberachat = {
          type = "IRC";
          max_kicks = "1";
          max_msgs = "4";
          max_whois = "1";
          sasl_mechanism = "PLAIN";
          sasl_username = "sreedev";
          sasl_password = "${secrets.irssi_liberachat_password}";
        };
      };
      channels = (
        { name = "#libera"; chatnet = "liberachat"; autojoin = "No"; },
        { name = "#irssi"; chatnet = "liberachat"; autojoin = "No"; },
      );

      aliases = {
        ATAG = "WINDOW SERVER";
        ADDALLCHANS = "SCRIPT EXEC foreach my \\$channel (Irssi::channels()) { Irssi::command(\"CHANNEL ADD -auto \\$channel->{visible_name} \\$channel->{server}->{tag} \\$channel->{key}\")\\;}";
        B = "BAN";
        BACK = "AWAY";
        BANS = "BAN";
        BYE = "QUIT";
        C = "CLEAR";
        CALC = "EXEC - if command -v bc >/dev/null 2>&1\\; then printf '%s=' '$*'\\; echo '$*' | bc -l\\; else echo bc was not found\\; fi";
        CHAT = "DCC CHAT";
        CS = "QUOTE CS";
        DATE = "TIME";
        DEHIGHLIGHT = "DEHILIGHT";
        DESCRIBE = "ACTION";
        DHL = "DEHILIGHT";
        EXEMPTLIST = "MODE $C +e";
        EXIT = "QUIT";
        GOTO = "SCROLLBACK GOTO";
        HIGHLIGHT = "HILIGHT";
        HL = "HILIGHT";
        HOST = "USERHOST";
        INVITELIST = "MODE $C +I";
        J = "JOIN";
        K = "KICK";
        KB = "KICKBAN";
        KN = "KNOCKOUT";
        LAST = "LASTLOG";
        LEAVE = "PART";
        M = "MSG";
        MS = "QUOTE MS";
        MUB = "UNBAN *";
        N = "NAMES";
        NMSG = "^MSG";
        NS = "QUOTE NS";
        OS = "QUOTE OS";
        P = "PART";
        Q = "QUERY";
        RESET = "SET -default";
        RUN = "SCRIPT LOAD";
        SAY = "MSG *";
        SB = "SCROLLBACK";
        SBAR = "STATUSBAR";
        SHELP = "QUOTE HELP";
        SIGNOFF = "QUIT";
        SV = "MSG * Irssi $J ($V) - https://irssi.org";
        T = "TOPIC";
        UB = "UNBAN";
        UMODE = "MODE $N";
        UNSET = "SET -clear";
        W = "WHO";
        WC = "WINDOW CLOSE";
        WG = "WINDOW GOTO";
        WJOIN = "JOIN -window";
        WI = "WHOIS";
        WII = "WHOIS $0 $0";
        WL = "WINDOW LIST";
        WN = "WINDOW NEW HIDDEN";
        WQUERY = "QUERY -window";
        WW = "WHOWAS";
      };

      statusbar = {
        items = {
          barstart = "{sbstart}";
          barend = "{sbend}";
          topicbarstart = "{topicsbstart}";
          topicbarend = "{topicsbend}";
          time = "{sb $Z}";
          user = "{sb {sbnickmode $cumode}$N{sbmode $usermode}{sbaway $A}}";
          window = "{sb $winref:$tag/$itemname{sbmode $M}}";
          window_empty = "{sb $winref{sbservertag $tag}}";
          prompt = "{prompt $[.15]itemname}";
          prompt_empty = "{prompt $winname}";
          topic = " $topic";
          topic_empty = " Irssi v$J - https://irssi.org";
          lag = "{sb Lag: $0-}";
          act = "{sb Act: $0-}";
          more = "-- more --";
        };

        default = {
          window = {
            disabled = "no";
            type = "window";
            placement = "bottom";
            position = "1";
            visible = "active";
            items = {
              barstart = { priority = "100"; };
              time = { };
              user = { };
              window = { };
              window_empty = { };
              lag = { priority = "-1"; };
              act = { priority = "10"; };
              more = { priority = "-1"; alignment = "right"; };
              barend = { priority = "100"; alignment = "right"; };
            };
          };

          window_inact = {

            type = "window";
            placement = "bottom";
            position = "1";
            visible = "inactive";

            items = {
              barstart = { priority = "100"; };
              window = { };
              window_empty = { };
              more = { priority = "-1"; alignment = "right"; };
              barend = { priority = "100"; alignment = "right"; };
            };
          };

          prompt = {

            type = "root";
            placement = "bottom";
            position = "100";
            visible = "always";

            items = {
              prompt = { priority = "-1"; };
              prompt_empty = { priority = "-1"; };
              input = { priority = "10"; };
            };
          };

          topic = {

            type = "root";
            placement = "top";
            position = "1";
            visible = "always";

            items = {
              topicbarstart = { priority = "100"; };
              topic = { };
              topic_empty = { };
              topicbarend = { priority = "100"; alignment = "right"; };
            };
          };
        };
      };
      settings = {
        core = { 
          real_name = "sreedev";
          user_name = "sreedev";
          nick = "sreedev";
        };
      };
    '';
  };
}