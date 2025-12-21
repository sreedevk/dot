{ pkgs, ... }:
let
  librepods = pkgs.stdenv.mkDerivation {
    pname = "librepods";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "kavishdevar";
      repo = "librepods";
      rev = "5cd7db574a4602e1bb0c485431e70a8e39f9f579";
      sha256 = "sha256-23G71hLCeUODDgubxGpFsHhLZHSXJ2kjzcxmXyEHJ+o=";
    };
    sourceRoot = "source/linux";
    buildInputs = with pkgs; [
      dbus
      egl-wayland
      kdePackages.qt6ct
      kdePackages.qtbase
      kdePackages.qtconnectivity
      kdePackages.qtdeclarative
      kdePackages.qtquick3d
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qtsvg
      kdePackages.qttools
      libpulseaudio
    ];
    nativeBuildInputs = with pkgs; [
      cmake
      pkg-config
      kdePackages.wrapQtAppsHook
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
