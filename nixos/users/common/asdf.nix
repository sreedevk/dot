{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ asdf-vm ];

  home.activation = {
    reshimASDF = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.asdf-vm}/bin/asdf reshim
    '';
  };

  home.file = {
    ".tool-versions" = {
      enable = true;
      recursive = true;
      text =
        let
          versions = [
            { tool = "bun"; version = "1.2.11"; }
            { tool = "deno"; version = "2.2.12"; }
            { tool = "elixir"; version = "1.18.3-otp-27"; }
            { tool = "erlang"; version = "27.3.3"; }
            { tool = "gleam"; version = "1.10.0"; }
            { tool = "golang"; version = "1.24.2"; }
            { tool = "nim"; version = "2.2.4"; }
            { tool = "ruby"; version = "3.4.2"; }
            { tool = "zig"; version = "0.14.0"; }
            { tool = "elm"; version = "0.19.1"; }
          ];
        in
        builtins.concatStringsSep "\n" (builtins.map (v: "${v.tool} ${v.version}") versions);
    };
  };
}
