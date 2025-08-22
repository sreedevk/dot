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
        settings = {
          auto_install = false;
          not_found_auto_install = false;
          quiet = true;
        };
        tools = {
          bun = "latest";
          chezscheme = "9.6.4";
          chicken = "5.4.0";
          clojure = "latest";
          deno = "latest";
          elixir = "1.18.4-otp-28";
          elm = "latest";
          erlang = "28.0.2";
          gleam = "latest";
          golang = "latest";
          nim = "latest";
          ruby = "latest";
          zig = "latest";
        };
      };
    };
  };
}
