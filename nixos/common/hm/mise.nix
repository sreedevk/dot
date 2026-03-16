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
          ruby.compile           = false;
          erlang.compile         = false;
          # all_compile            = false;
        };
        tools = {
          bun        = "latest";
          chicken    = "5.4.0";
          clojure    = "latest";
          crystal    = "latest";
          deno       = "latest";
          elixir     = "latest";
          elm        = "latest";
          erlang     = "latest";
          gleam      = "latest";
          golang     = "latest";
          zig        = "latest";
          ruby       = "latest";
        };
      };
    };
  };
}
