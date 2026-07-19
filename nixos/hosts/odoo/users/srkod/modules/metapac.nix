{ pkgs, ... }:
{
  home.packages = with pkgs; [
    metapac
  ];

  xdg.configFile = {
    "paru/paru.conf" = {
      enable = true;
      text = ''
        [options]
        PgpFetch
        Devel
        Provides
        DevelSuffixes = -git -cvs -svn -bzr -darcs -always -hg -fossil
        BottomUp
        CombinedUpgrade
        UpgradeMenu
        NewsOnUpgrade
        SudoLoop
        CleanAfter
        RemoveMake

        [bin]
        FileManager = ls
      '';
    };
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
          binstall = true;
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
              name = "system:org.jellyfin.JellyfinDesktop";
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
            "ccid"
            "clang"
            "cliphist"
            "cmake"
            "cpio"
            "cups"
            "dhcpcd"
            "distrobox"
            "dmidecode"
            "docker"
            "docker-buildx"
            "docker-compose"
            "efibootmgr"
            "egl-wayland"
            "eglexternalplatform"
            "evtest"
            "exfatprogs"
            "fish"
            "flatpak"
            "fprintd"
            "fuse2"
            "fwupd"
            "gdb"
            "git"
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
            "hplip"
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
            "libcamera-tools"
            "libnotify"
            "libpam-google-authenticator"
            "libqalculate"
            "libvirt"
            "libxcrypt-compat"
            "linux"
            "linux-docs"
            "linux-firmware"
            "linux-firmware-qlogic"
            "linux-headers"
            "linux-lts"
            "linux-lts-docs"
            "linux-lts-headers"
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
            "openblas"
            "opendoas"
            "openldap"
            "openresolv"
            "openssh"
            "openvpn"
            "os-prober"
            "pacutils"
            "pamtester"
            "parallel"
            "paru"
            "paru-debug"
            "pcsc-tools"
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
            "python-pyscard"
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
            "rose-pine-hyprcursor"
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
            "strace"
            "supercollider"
            "swig"
            "tailscale"
            "texlive-binextra"
            "thunderbird"
            "tk"
            "tree-sitter-cli"
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
          ];
        };
        bun = {
          packages = [
            "eslint"
            "jiti"
            "prettier"
            "rtlcss"
          ];
        };
        cargo = {
          packages = [
            "basalt-tui"
            "but"
            "cargo-audit"
            "cargo-binstall"
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
            "odoo-lsp"
            "sea-orm-cli"
            "sqlx-cli"
            "term-transcript-cli"
            "trunk"
            "uiua"
            "wasm-pack"
            "wasm-tools"
            "workmux"
          ];
        };
      };
    };
  };
}
