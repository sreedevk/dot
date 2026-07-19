{ pkgs, ... }:
{
  home.packages = with pkgs; [
    metapac
  ];

  xdg.configFile = {
    "metapac/config.toml" = {
      enable = true;
      source = (pkgs.formats.toml { }).generate "metapac.config.toml" {
        enabled_backends = [
          "arch"
          "cargo"
          "flatpak"
          "bun"
        ];
        # NOTE: since we are using nix, each individual metapac is isolated.
        # hostname groups are not required
        hostname_groups_enabled = false;
        arch = {
          package_manager = "paru";
        };
        cargo = {
          locked = false;
          binstall = false;
        };
      };
    };

    "metapac/groups/main.toml" = {
      enable = true;
      source = (pkgs.formats.toml { }).generate "metapac.config.toml" {
        flatpak = {
          repos = [
            {
              name = "system:flathub";
              options = {
                url = "https://dl.flathub.org/repo/";
              };
            }
            {
              name = "user:flathub";
              options = {
                url = "https://dl.flathub.org/repo/";
              };
            }
          ];
          packages = [
            {
              name = "system:com.github.tchx84.Flatseal";
              options = {
                remote = "flathub";
              };
            }
            {
              name = "system:io.github.flattool.Warehouse";
              options = {
                remote = "flathub";
              };
            }
            {
              name = "system:io.github.gaheldev.Millisecond";
              options = {
                remote = "flathub";
              };
            }
            {
              name = "system:org.darktable.Darktable";
              options = {
                remote = "flathub";
              };
            }
            {
              name = "system:org.jellyfin.JellyfinDesktop";
              options = {
                remote = "flathub";
              };
            }
            {
              name = "system:org.prismlauncher.PrismLauncher";
              options = {
                remote = "flathub";
              };
            }
            {
              name = "user:com.github.Matoking.protontricks";
              options = {
                remote = "flathub";
              };
            }
          ];
        };
        arch = {
          packages = [
            "alsa-firmware"
            "alsa-plugins"
            "alsa-utils"
            "amd-ucode"
            "android-tools"
            "asusctl"
            "autoconf-archive"
            "base"
            "base-devel"
            "bash-completion"
            "bc"
            "bind"
            "bluez-tools"
            "bluez-utils"
            "boost"
            "btrfs-progs"
            "catppuccin-gtk-theme-mocha"
            "ccache"
            "clang"
            "cliphist"
            "cmake"
            "cpio"
            "cuda"
            "dhcpcd"
            "distrobox"
            "dmidecode"
            "docker"
            "docker-buildx"
            "docker-compose"
            "droidcam"
            "efibootmgr"
            "egl-wayland"
            "eglexternalplatform"
            "envycontrol"
            "evtest"
            "exfatprogs"
            "fish"
            "flatpak"
            "fprintd"
            "fuse2"
            "fwupd"
            "gamescope"
            "gdb"
            "git"
            "git-filter-repo"
            "git-lfs"
            "gnome-keyring"
            "gnumeric"
            "gnuplot"
            "gpu-screen-recorder"
            "gpu-screen-recorder-gtk"
            "grim"
            "grub"
            "gst-plugin-libcamera"
            "gst-plugins-bad"
            "gst-plugins-base"
            "gst-plugins-good"
            "gstreamer"
            "help2man"
            "howdy-git"
            "hping"
            "impala"
            "incus"
            "incus-tools"
            "inetutils"
            "inotify-tools"
            "iw"
            "iwd"
            "jellium-desktop-git"
            "jq"
            "kexec-tools"
            "kmon"
            "kvantum-qt5"
            "kvantum-theme-materia"
            "less"
            "lib32-gdk-pixbuf2"
            "lib32-libpipewire"
            "lib32-libpulse"
            "lib32-libvdpau"
            "lib32-libxi"
            "lib32-libxrandr"
            "lib32-libxrender"
            "lib32-libxtst"
            "lib32-mesa"
            "lib32-mesa-utils"
            "lib32-nvidia-utils"
            "lib32-vulkan-intel"
            "lib32-zlib"
            "libcamera-tools"
            "libfido2"
            "libnotify"
            "libpam-google-authenticator"
            "libqalculate"
            "libva-nvidia-driver"
            "libvirt"
            "libxcrypt-compat"
            "linux"
            "linux-docs"
            "linux-firmware"
            "linux-firmware-qlogic"
            "linux-g14"
            "linux-g14-headers"
            "linux-headers"
            "lld"
            "lsof"
            "luarocks"
            "lvm2"
            "man-pages"
            "mariadb-clients"
            "mesa"
            "mesa-utils"
            "meson"
            "mpv"
            "mullvad-vpn-bin"
            "musl"
            "neovim"
            "networkmanager"
            "ninja"
            "nmap"
            "noto-fonts"
            "noto-fonts-cjk"
            "noto-fonts-emoji"
            "nvidia-container-toolkit"
            "nvidia-open-dkms"
            "nvidia-settings"
            "openblas"
            "opencl-nvidia"
            "opendoas"
            "openldap"
            "openresolv"
            "openssh"
            "openvpn"
            "os-prober"
            "pacutils"
            "pamtester"
            "parallel"
            "perf"
            "pipewire-alsa"
            "pipewire-libcamera"
            "pipewire-pulse"
            "pipewire-v4l2"
            "podman"
            "podman-compose"
            "polkit-qt6"
            "postgresql-libs"
            "power-profiles-daemon"
            "progress"
            "python-jinja"
            "python-ply"
            "python-systemd"
            "python-xlib"
            "qemu-user-static"
            "qemu-user-static-binfmt"
            "qjackctl"
            "qt5-tools"
            "qt5-wayland"
            "qt5ct"
            "qt6-connectivity"
            "qt6-multimedia"
            "qt6-multimedia-ffmpeg"
            "qt6-tools"
            "qt6ct"
            "raylib"
            "realtime-privileges"
            "reflector"
            "rlwrap"
            "rog-control-center"
            "sc3-plugins"
            "scdoc"
            "scx-scheds"
            "scx-tools"
            "sdl2_image"
            "sdl2_mixer"
            "sdl2_net"
            "sdl2_ttf"
            "seahorse"
            "slurp"
            "smartmontools"
            "snd"
            "sndio"
            "sniffnet"
            "sof-firmware"
            "sof-tools"
            "songrec"
            "squashfs-tools"
            "ssh-tpm-agent"
            "steam"
            "strace"
            "supercollider"
            "supergfxctl"
            "tailscale"
            "texlive-binextra"
            "thunderbird"
            "ttf-dejavu"
            "ttf-iosevka-nerd"
            "ttf-jetbrains-mono"
            "ttf-jetbrains-mono-nerd"
            "ttf-liberation"
            "ttf-sourcecodepro-nerd"
            "udisks2"
            "unixodbc"
            "unzip"
            "upower"
            "usbutils"
            "uwsm"
            "v4l2loopback-dc-dkms"
            "v4l2loopback-dkms"
            "vcpkg"
            "virt-manager"
            "virtualbox"
            "virtualbox-host-dkms"
            "vulkan-intel"
            "waydroid"
            "webkit2gtk"
            "webkit2gtk-4.1"
            "wev"
            "whois"
            "wireguard-tools"
            "wireless_tools"
            "wireplumber"
            "wl-clipboard"
            "wlroots0.19"
            "wlsunset"
            "woff2-font-awesome"
            "xclip"
            "xdg-desktop-portal-gnome"
            "xdo"
            "xdotool"
            "xf86-video-vesa"
            "xorg-server"
            "xorg-server-devel"
            "xorg-server-xephyr"
            "xorg-xev"
            "xorg-xinit"
            "xorg-xrandr"
            "xorg-xwininfo"
            "xterm"
            "xtrans"
            "yubico-pam"
            "zarchive"
            "zip"
            "zmap"
            "zsh"
            "zsh-completions"
          ];
        };
        bun = {
          packages = [
            "eslint"
            "jiti"
            "prettier"
          ];
        };
        cargo = {
          packages = [
            "basalt-tui"
            "but"
            "cargo-audit"
            "cargo-bloat"
            "cargo-expand"
            "cargo-generate"
            "cargo-udeps"
            "cargo-update"
            "cargo-watch"
            "cl-wordle"
            "deduplicator"
            "flamegraph"
            "license-generator"
            "loco"
            "ncopds"
            "sea-orm-cli"
            "sqlx-cli"
            "term-transcript-cli"
            "trunk"
            "uiua"
            "wasm-opt"
            "wasm-pack"
            "wasm-tools"
            "workmux"
          ];
        };
      };
    };
  };
}
