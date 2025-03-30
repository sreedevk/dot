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
            { tool = "bun"; version = "1.2.8"; }
            { tool = "deno"; version = "2.2.6"; }
            { tool = "elixir"; version = "1.18.3-otp-27"; }
            { tool = "erlang"; version = "27.3.1"; }
            { tool = "gleam"; version = "1.9.1"; }
            { tool = "golang"; version = "1.24.2"; }
            { tool = "nim"; version = "2.2.2"; }
            { tool = "ruby"; version = "3.4.2"; }
            { tool = "zig"; version = "0.14.0"; }
          ];
        in
        builtins.concatStringsSep "\n" (builtins.map (v: "${v.tool} ${v.version}") versions);
    };
  };
}
