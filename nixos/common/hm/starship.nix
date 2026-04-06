{ lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      format = lib.concatStrings [
        "$os"
        "$username"
        "$hostname"
        "$localip"
        "$directory"
        "$status"
        "$git_branch"
        "$cmd_duration"
        "$jobs"
        "$character"
      ];
      line_break = {
        disabled = true;
      };
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
        vimcmd_symbol = "[λ](bold purple)";
      };
      localip = {
        ssh_only = true;
      };
      os = {
        style = "bold purple";
        disabled = false;
        symbols = {
          Arch = "   ";
          Ubuntu = " 🖧  ";
          Debian = " ◎ ";
        };
      };
      directory = {
        truncation_length = 2;
        truncate_to_repo = true;
        read_only = " [RO]";
        read_only_style = "bold dimmed red";
        truncation_symbol = "";
      };
      username = {
        format = "[── $user]($style)@";
        style_user = "bold purple";
        style_root = "bold red";
        show_always = true;
      };

      git_branch = {
        format = "[» $branch]($style) ";
        style = "bold italic green";
        symbol = "";
      };
      hostname = {
        format = "[$hostname]($style) ";
        style = "bold dimmed purple";
        trim_at = "-";
        ssh_only = false;
        disabled = false;
      };
      cmd_duration = {
        format = "[$duration ]($style)";
        min_time = 4;
        show_milliseconds = true;
        disabled = false;
        style = "bold italic blue";
      };
      jobs = {
        threshold = 1;
        symbol = "+";
        style = "bold red";
      };
    };
  };
}
