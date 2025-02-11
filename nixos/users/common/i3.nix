{ pkgs, config, opts, ... }:
let
  wallpaper_path = "${opts.directories.wallpapers}/${opts.wallpaper}";
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    ${pkgs.feh}/bin/feh --no-fehbg --bg-scale ${wallpaper_path} 
  '';
in
{
  home.packages = with pkgs; [
    arandr
    python311Packages.i3ipc
  ];

  home.file = {
    "i3config" = {
      enable = true;
      recursive = false;
      executable = false;
      target = ".config/i3/config";
      text = ''
        # terminal
        set $term ${config.programs.alacritty.package}/bin/alacritty

        # Application Launcher
        set $app_launcher    "${pkgs.rofi}/bin/rofi -show drun"
        set $window_switcher "${pkgs.rofi}/bin/rofi -show window"

        # Setup Key Definitions
        set $mod Mod4

        # AutoStart Applications
        exec_always --no-startup-id ${pkgs.autorandr}/bin/autorandr -c --match-edid
        exec_always --no-startup-id ~/.config/polybar/launch.sh
        exec_always --no-startup-id ${pkgs.autotiling}/bin/autotiling
        exec_always --no-startup-id picom -b
        exec_always --no-startup-id ${set-wallpaper}/bin/set-wallpaper

        # Disable Screen Blanking
        exec --no-startup-id xset s off
        exec --no-startup-id xset -dpms

        # Colors
        set $rosewater #f4dbd6
        set $flamingo  #f0c6c6
        set $pink      #f5bde6
        set $mauve     #c6a0f6
        set $red       #ed8796
        set $maroon    #ee99a0
        set $peach     #f5a97f
        set $green     #a6da95
        set $teal      #8bd5ca
        set $sky       #91d7e3
        set $sapphire  #7dc4e4
        set $blue      #8aadf4
        set $lavender  #b7bdf8
        set $text      #cad3f5
        set $subtext1  #b8c0e0
        set $subtext0  #a5adcb
        set $overlay2  #939ab7
        set $overlay1  #8087a2
        set $overlay0  #6e738d
        set $surface2  #5b6078
        set $surface1  #494d64
        set $surface0  #363a4f
        set $base      #24273a
        set $mantle    #1e2030
        set $crust     #181926

        # UX + Design Config
        default_border                pixel 1
        hide_edge_borders             smart
        default_floating_border       pixel 0
        font                          pango:Iosevka NF 11
        floating_modifier             $mod
        focus_follows_mouse           yes
        workspace_auto_back_and_forth no
        smart_gaps                    off
        smart_borders                 on
        gaps                          inner 5
        gaps                          outer 5

        # Shortcuts - Terminal + Access
        bindsym $mod+Return            exec --no-startup-id $term
        bindsym $mod+KP_Enter          exec --no-startup-id $term
        bindsym $mod+d                 exec --no-startup-id $app_launcher
        bindsym $mod+Ctrl+d            exec --no-startup-id "dmenu_run"
        bindsym $mod+Tab               exec --no-startup-id $window_switcher
        bindsym Ctrl+space             exec --no-startup-id "${pkgs.dunst}/bin/dunstctl close-all"

        # Power Management
        bindsym $mod+Shift+period      exec --no-startup-id "systemctl suspend"

        # Brightness
        bindsym XF86MonBrightnessUp    exec --no-startup-id "${pkgs.brightnessctl}/bin/brightnessctl set +10%"
        bindsym XF86MonBrightnessDown  exec --no-startup-id "${pkgs.brightnessctl}/bin/brightnessctl set 10%-"

        # Volume
        bindsym XF86AudioRaiseVolume   exec --no-startup-id pactl set-sink-volume $(pactl info | grep 'Default Sink' | awk '{print $3}') +5%
        bindsym XF86AudioLowerVolume   exec --no-startup-id pactl set-sink-volume $(pactl info | grep 'Default Sink' | awk '{print $3}') -5%
        bindsym XF86AudioMute          exec --no-startup-id pactl set-sink-mute $(pactl info | grep 'Default Sink' | awk '{print $3}') toggle
        bindsym XF86AudioPlay          exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause
        bindsym XF86AudioPrev          exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous
        bindsym XF86AudioNext          exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next

        # Shortcuts - Screenshots
        bindsym Print                  exec --no-startup-id "${pkgs.maim}/bin/maim -i $(xdotool getactivewindow) ~/Media/screenshots/$(date +%s).png"
        bindsym $mod+Ctrl+s  --release exec --no-startup-id "${pkgs.maim}/bin/maim -s -d 0.2 ~/Media/screenshots/$(date +%s).png"
        bindsym $mod+Shift+s --release exec --no-startup-id "${pkgs.maim}/bin/maim -s -d 0.2 | xclip -selection clipboard -t image/png"

        # Shortcuts - Audio
        bindsym $mod+a            exec --no-startup-id "pavucontrol"

        # Shortcuts - Notifications
        bindsym $mod+n       --release exec --no-startup-id "${pkgs.dunst}/bin/dunstctl set-paused toggle"

        # Shortcuts - Process Control
        bindsym $mod+Ctrl+x  --release exec --no-startup-id "xkill"
        bindsym $mod+Shift+q kill

        # Shortcuts - UX + Design
        bindsym $mod+p                 exec --no-startup-id "pkill picom"
        bindsym $mod+Shift+p           exec --no-startup-id "picom -b"

        # Shortcuts - Entry & Exit
        bindsym $mod+Shift+c         reload
        bindsym $mod+Shift+r         restart
        bindsym $mod+Shift+e         exec "i3-msg exit"

        # Shortcuts - Focus
        bindsym $mod+h               focus left
        bindsym $mod+j               focus down
        bindsym $mod+k               focus up
        bindsym $mod+l               focus right

        # Shortcuts - Move
        bindsym $mod+Shift+h         move left
        bindsym $mod+Shift+j         move down
        bindsym $mod+Shift+k         move up
        bindsym $mod+Shift+l         move right

        # Bar Mode Toggle
        bindsym $mod+m               exec --no-startup-id polybar-msg cmd toggle

        # Layouts
        bindsym $mod+s               layout stacking
        bindsym $mod+w               layout tabbed
        bindsym $mod+e               layout toggle split
        bindsym $mod+f               fullscreen toggle
        bindsym $mod+Shift+a         focus parent
        bindsym $mod+Shift+space     floating toggle
        bindsym $mod+Ctrl+s          sticky toggle
        bindsym $mod+Shift+minus     move scratchpad
        bindsym $mod+minus           scratchpad show
        bindsym $mod+Shift+backslash split h; exec --no-startup-id notify-send -a i3wm "Tiling Horizontally"
        bindsym $mod+backslash       split v; exec --no-startup-id notify-send -a i3wm "Tiling Vertically"

        bindsym $mod+Ctrl+l          workspace next
        bindsym $mod+Ctrl+h          workspace prev

        bindsym $mod+0               exec --no-startup-id ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid

        # Workspace Control
        set $ws1 1
        set $ws2 2
        set $ws3 3
        set $ws4 4
        set $ws5 5
        set $ws6 6
        set $ws7 7
        set $ws8 8
        set $ws9 9

        workspace $ws1 output DP-1-2
        workspace $ws2 output DP-1-2
        workspace $ws3 output DP-1-2
        workspace $ws4 output eDP-1-1
        workspace $ws5 output DP-1-1
        workspace $ws6 output DP-1-1
        workspace $ws7 output DP-1-1
        workspace $ws8 output DP-1-1

        bindsym $mod+1 workspace $ws1
        bindsym $mod+2 workspace $ws2
        bindsym $mod+3 workspace $ws3
        bindsym $mod+4 workspace $ws4
        bindsym $mod+5 workspace $ws5
        bindsym $mod+6 workspace $ws6
        bindsym $mod+7 workspace $ws7
        bindsym $mod+8 workspace $ws8
        bindsym $mod+9 workspace $ws9

        bindsym $mod+Ctrl+1 move container to workspace $ws1
        bindsym $mod+Ctrl+2 move container to workspace $ws2
        bindsym $mod+Ctrl+3 move container to workspace $ws3
        bindsym $mod+Ctrl+4 move container to workspace $ws4
        bindsym $mod+Ctrl+5 move container to workspace $ws5
        bindsym $mod+Ctrl+6 move container to workspace $ws6
        bindsym $mod+Ctrl+7 move container to workspace $ws7
        bindsym $mod+Ctrl+8 move container to workspace $ws8
        bindsym $mod+Ctrl+9 move container to workspace $ws9

        bindsym $mod+Shift+1 move container to workspace $ws1; workspace $ws1
        bindsym $mod+Shift+2 move container to workspace $ws2; workspace $ws2
        bindsym $mod+Shift+3 move container to workspace $ws3; workspace $ws3
        bindsym $mod+Shift+4 move container to workspace $ws4; workspace $ws4
        bindsym $mod+Shift+5 move container to workspace $ws5; workspace $ws5
        bindsym $mod+Shift+6 move container to workspace $ws6; workspace $ws6
        bindsym $mod+Shift+7 move container to workspace $ws7; workspace $ws7
        bindsym $mod+Shift+8 move container to workspace $ws8; workspace $ws8
        bindsym $mod+Shift+9 move container to workspace $ws9; workspace $ws9

        # target                 title     bg     text   indicator  border
        client.focused           $mauve    $mauve $base  $rosewater $peach
        client.focused_inactive  $mauve    $base  $text  $rosewater $base
        client.unfocused         $base     $base  $text  $rosewater $base
        client.urgent            $peach    $base  $peach $overlay0  $peach
        client.placeholder       $overlay0 $base  $text  $overlay0  $overlay0
        client.background        $base

        # assign [class="Slack"]                     $ws4
        # assign [class="Brave-browser"]             $ws2

        for_window [urgent=latest]                      focus
        for_window [class="Pavucontrol"]                floating enable resize set 800 500
        for_window [window_role="pop-up"]               floating enable
        for_window [window_role="task_dialog"]          floating enable
        for_window [window_role="GtkFileChooserDialog"] floating enable resize set 800 500

        bindsym $mod+r mode "resize"
        mode "resize" {
                bindsym l resize shrink width 5 px or 5 ppt
                bindsym j resize grow height 10 px or 10 ppt
                bindsym k resize shrink height 10 px or 10 ppt
                bindsym h resize grow width 5 px or 5 ppt
                bindsym Return mode "default"
                bindsym Escape mode "default"
        }
      '';
    };
  };
}
