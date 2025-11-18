{ pkgs, ... }:
let
  librepods = pkgs.stdenv.mkDerivation {
    pname = "librepods";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "kavishdevar";
      repo = "librepods";
      rev = "master";
      sha256 = "sha256-vWtBSHYPtrSmYzY25a1RcVUlpaXF2WzNLke7RiST/38=";
    };
    sourceRoot = "source/linux";
    buildInputs = [
      pkgs.qt6.qtbase
      pkgs.qt6.qtdeclarative
      pkgs.qt6.qtconnectivity
      # pkgs.qt5.qtquickcontrols
      pkgs.libpulseaudio
    ];
    nativeBuildInputs = [
      pkgs.cmake
      pkgs.pkg-config
      pkgs.qt6.wrapQtAppsHook
    ];
    dontWrapQtApps = true;
    installPhase = ''
      mkdir -p $out/bin
      cp librepods $out/bin/
    '';
  };
in
{
  home.packages = [ librepods ];
  systemd.user = {
    services = {
      librepods = {
        Unit = {
          Description = "Librepods Airpods Controller";
          PartOf = "graphical-session.target";
          After = "graphical-session.target";
        };
        Service = {
          ExecStart = "${librepods}/bin/librepods";
          Restart = "always";
          RestartSec = 3;
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}
