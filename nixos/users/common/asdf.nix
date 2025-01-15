{ pkgs, ... }:
{
  home.packages = with pkgs; [ asdf-vm ];
  home.file = {
    ".tool-versions" = {
      enable = true;
      recursive = true;
      text =
        let
          versions = [
            { tool = "bun"; version = "1.1.42"; }
            { tool = "deno"; version = "2.1.4"; }
            { tool = "elixir"; version = "1.18.0-otp-27"; }
            { tool = "erlang"; version = "27.2"; }
            { tool = "gleam"; version = "1.6.3"; }
            { tool = "golang"; version = "1.23.4"; }
            { tool = "nim"; version = "2.2.0"; }
            { tool = "opam"; version = "2.3.0"; }
            { tool = "ruby"; version = "3.4.1"; }
            { tool = "zig"; version = "0.13.0"; }
          ];
        in
        builtins.concatStringsSep "\n" (builtins.map (v: "${v.tool} ${v.version}") versions);
    };
  };
}
