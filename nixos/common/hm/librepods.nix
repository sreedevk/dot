{ pkgs
, config
, ...
}:
let
  librepods = pkgs.stdenv.mkDerivation {
    pname = "librepods";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "kavishdevar";
      repo = "librepods";
      rev = "fd33528218b7e1378429c4d773d757e4be36416f";
      sha256 = "sha256-NhoWMx9M9X2pHMYZCre6We80jl8XV6843J5y37v9Hyg=";
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
    installPhase = ''
      mkdir -p $out/bin
      cp librepods $out/bin/
    '';
  };
in
{
  xdg.desktopEntries = {
    librepods = {
      name = "Librepods";
      type = "Application";
      exec = "env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia ${config.lib.nixGL.wrapOffload librepods}/bin/librepods";
      comment = "librepods autostart";
      icon = "librepods";
      terminal = false;
    };
  };
}
