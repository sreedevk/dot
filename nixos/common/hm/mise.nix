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
          auto_install           = false;
          not_found_auto_install = false;
          quiet                  = false;
        };
        tools = {
          bun        = "latest";
          chicken    = "5.4.0";
          clojure    = "latest";
          deno       = "latest";
          elixir     = "latest";
          elm        = "latest";
          erlang     = "latest";
          gleam      = "latest";
          golang     = "latest";
          zig        = "latest";
        };
      };
    };
  };
}
