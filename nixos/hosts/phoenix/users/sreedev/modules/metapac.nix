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

    "metapac/groups/arch.toml" = {
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
            "android-tools"
            "amd-ucode"
            "alsa-firmware"
            "alsa-plugins"
            "alsa-utils"
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
            "efibootmgr"
            "eglexternalplatform"
            "egl-wayland"
            "evtest"
            "exfatprogs"
            "fish"
            "flatpak"
            "fprintd"
            "fuse2"
            "fwupd"
            "gdb"
            "git"
            "git-filter-repo"
            "git-lfs"
            "gnome-keyring"
            "gnumeric"
            "gnuplot"
            "gpu-screen-recorder"
            "grim"
            "grub"
            "gst-plugin-libcamera"
            "gst-plugins-bad"
            "gst-plugins-base"
            "gst-plugins-good"
            "gstreamer"
            "help2man"
            "hping"
            "impala"
            "incus"
            "incus-tools"
            "inetutils"
            "inotify-tools"
            "iw"
            "iwd"
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
            "qt5ct"
            "qt5-tools"
            "qt5-wayland"
            "qt6-connectivity"
            "qt6ct"
            "qt6-multimedia"
            "qt6-multimedia-ffmpeg"
            "qt6-tools"
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
            "v4l2loopback-dkms"
            "vcpkg"
            "virt-manager"
            "virtualbox"
            "virtualbox-host-dkms"
            "vulkan-intel"
            "waydroid"
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
            "catppuccin-gtk-theme-mocha"
            "droidcam"
            "envycontrol"
            "gpu-screen-recorder-gtk"
            "howdy-git"
            "mullvad-vpn-bin"
            "pamtester"
            "supergfxctl"
            "v4l2loopback-dc-dkms"
            "webkit2gtk"
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
            {
              name = "basalt-tui";
              options = {
                version = "0.12.3";
                features = [ ];
              };
            }
            {
              name = "blaze-ssh";
              options = {
                version = "0.0.8";
                git = "https://github.com/sreedevk/blaze-ssh";
                features = [ ];
              };
            }
            {
              name = "but";
              options = {
                version = "0.0.0";
                features = [ ];
              };
            }
            {
              name = "cargo-audit";
              options = {
                version = "0.22.1";
                features = [ ];
              };
            }
            {
              name = "cargo-bloat";
              options = {
                version = "0.12.1";
                features = [ ];
              };
            }
            {
              name = "cargo-expand";
              options = {
                version = "1.0.121";
                features = [ ];
              };
            }
            {
              name = "cargo-generate";
              options = {
                version = "0.23.7";
                features = [ ];
              };
            }
            {
              name = "cargo-udeps";
              options = {
                version = "0.1.60";
                features = [ ];
              };
            }
            {
              name = "cargo-update";
              options = {
                version = "18.1.1";
                features = [ ];
              };
            }
            {
              name = "cargo-watch";
              options = {
                version = "8.5.3";
                features = [ ];
              };
            }
            {
              name = "cl-wordle";
              options = {
                version = "0.4.0";
                features = [ ];
              };
            }
            {
              name = "cwry";
              options = {
                version = "1.0.4";
                features = [ ];
              };
            }
            {
              name = "deduplicator";
              options = {
                version = "0.3.1";
                features = [ ];
              };
            }
            {
              name = "dioxus-cli";
              options = {
                version = "0.7.3";
                features = [ ];
              };
            }
            {
              name = "flamegraph";
              options = {
                version = "0.6.11";
                features = [ ];
              };
            }
            {
              name = "gitbutler-cli";
              options = {
                version = "0.0.0";
                features = [ ];
              };
            }
            {
              name = "license-generator";
              options = {
                version = "1.3.0";
                features = [ ];
              };
            }
            {
              name = "loco";
              options = {
                version = "0.16.3";
                features = [ ];
              };
            }
            {
              name = "ncopds";
              options = {
                version = "0.1.0";
                features = [ ];
              };
            }
            {
              name = "sea-orm-cli";
              options = {
                version = "1.1.19";
                features = [ ];
              };
            }
            {
              name = "sqlx-cli";
              options = {
                version = "0.8.6";
                features = [ ];
              };
            }
            {
              name = "term-transcript-cli";
              options = {
                version = "0.4.0";
                features = [ ];
              };
            }
            {
              name = "trunk";
              options = {
                version = "0.21.14";
                features = [ ];
              };
            }
            {
              name = "uiua";
              options = {
                version = "0.18.1";
                features = [ ];
              };
            }
            {
              name = "wasm-opt";
              options = {
                version = "0.116.1";
                features = [ ];
              };
            }
            {
              name = "wasm-pack";
              options = {
                version = "0.14.0";
                features = [ ];
              };
            }
            {
              name = "wasm-tools";
              options = {
                version = "1.245.1";
                features = [ ];
              };
            }
            {
              name = "workmux";
              options = {
                version = "0.1.124";
                features = [ ];
              };
            }
          ];
        };
      };
    };
  };
}
