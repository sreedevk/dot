{ pkgs
, lib
, ...
}:
{
  home.packages = with pkgs; [
    asdf-vm
    jdk21_headless
  ];

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
            { tool = "bun";     version = "1.2.17";      }
            { tool = "clojure"; version = "1.12.1.1550"; }
            { tool = "deno";    version = "2.3.7";       }
            { tool = "elixir";  version = "1.18.4";      }
            { tool = "elm";     version = "0.19.1";      }
            { tool = "erlang";  version = "27.3.3";      }
            { tool = "gleam";   version = "1.11.1";      }
            { tool = "golang";  version = "1.24.4";      }
            { tool = "nim";     version = "2.2.4";       }
            { tool = "ruby";    version = "3.4.2";       }
            { tool = "scala";   version = "3.7.1";       }
            { tool = "zig";     version = "0.14.0";      }
          ];
        in
        builtins.concatStringsSep "\n" (builtins.map (v: "${v.tool} ${v.version}") versions);
    };
  };
}
