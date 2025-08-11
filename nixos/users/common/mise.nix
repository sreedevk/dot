{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mise
    usage
  ];

  home.file = {
    ".config/mise/config.toml" = {
      enable = true;
      recursive = true;
      source = (pkgs.formats.toml { }).generate "miseconf" {
        tools = {
          bun = "1.2.17";
          clojure = "1.12.1.1550";
          deno = "2.3.7";
          elixir = "1.18.4";
          elm = "0.19.1";
          erlang = "27.3.3";
          gleam = "1.11.1";
          golang = "1.24.4";
          nim = "2.2.4";
          ruby = "3.4.2";
          zig = "0.14.0";
        };
      };
    };
  };
}
