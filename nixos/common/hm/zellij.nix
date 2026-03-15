{ config, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      copy_command = "wl-copy";
      auto_layout = true;
      default_shell = "${pkgs.fish}/bin/fish";
      copy_on_select = false;
      disable_session_metadata = false;
      mirror_session = false;
      mouse_mode = false;
      on_force_close = "quit";
      pane_viewport_serialization = false;
      scroll_buffer_size = 50000;
      scrollback_editor = "${config.programs.neovim.package}/bin/nvim";
      session_serialization = true;
      simplified_ui = true;
      styled_underlines = false;
      ui = {
        pane_frames = {
          hide_session_name = false;
          rounded_corners = false;
        };
      };
    };
    extraConfig = ''
      keybinds clear-defaults=true {
      	normal  {
          bind "Ctrl b" { SwitchToMode "tmux"; }
      	}
        entersearch {
          bind "Esc" "Esc" { SwitchToMode "Scroll"; }
          bind "Enter" { SwitchToMode "Search"; }
        }
        move {
          bind "Esc" { SwitchToMode "Normal"; }
          bind "Enter" { SwitchToMode "Normal"; }
          bind "h" { MovePane "Left"; }
          bind "l" { MovePane "Right"; }
          bind "k" { MovePane "Up"; }
          bind "j" { MovePane "Down"; }
        }
        search {
          bind "Esc" { ScrollToBottom; SwitchToMode "Normal"; }
          bind "j" "Down" { ScrollDown; }
          bind "k" "Up" { ScrollUp; }
          bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
          bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
          bind "d" { HalfPageScrollDown; }
          bind "u" { HalfPageScrollUp; }
          bind "n" { Search "down"; }
          bind "p" { Search "up"; }
          bind "c" { SearchToggleOption "CaseSensitivity"; }
          bind "w" { SearchToggleOption "Wrap"; }
          bind "o" { SearchToggleOption "WholeWord"; }
        }
        renametab {
          bind "Esc" { UndoRenameTab; SwitchToMode "Normal"; }
          bind "Enter" { SwitchToMode "Normal"; }
        }
        renamepane {
          bind "Esc" { UndoRenamePane; SwitchToMode "Normal"; }
          bind "Enter" { SwitchToMode "Normal"; }
        }
        session {
          bind "w"{
              LaunchOrFocusPlugin "session-manager" {
                  floating true
                  move_to_focused_tab true
              };
              SwitchToMode "Normal"
          } 
          bind "c" {
              LaunchOrFocusPlugin "configuration" {
                  floating true
                  move_to_focused_tab true
              };
              SwitchToMode "Normal"
          }
          bind "p" {
              LaunchOrFocusPlugin "plugin-manager" {
                  floating true
                  move_to_focused_tab true
              };
              SwitchToMode "Normal"
          }
        }
        pane {
          bind "Esc" { SwitchToMode "Normal"; }
          bind "Enter" { SwitchToMode "Normal"; }
          bind "h" "Left" { MoveFocus "Left"; }
          bind "l" "Right" { MoveFocus "Right"; }
          bind "j" "Down" { MoveFocus "Down"; }
          bind "k" "Up" { MoveFocus "Up"; }
          bind "p" { SwitchFocus; }
          bind "n" { NewPane; SwitchToMode "Normal"; }
          bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
          bind "x" { CloseFocus; SwitchToMode "Normal"; }
          bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
          bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
          bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
          bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
          bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
        }
        scroll {
          bind "Esc" { ScrollToBottom; SwitchToMode "Normal"; }
          bind "e" { EditScrollback; SwitchToMode "Normal"; }
          bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
          bind "j" "Down" { ScrollDown; }
          bind "k" "Up" { ScrollUp; }
          bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
          bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
          bind "d" { HalfPageScrollDown; }
          bind "u" { HalfPageScrollUp; }
        }
        resize {
          bind "Esc" { SwitchToMode "Normal"; }
          bind "h" "Left" { Resize "Increase Left"; }
          bind "j" "Down" { Resize "Increase Down"; }
          bind "k" "Up" { Resize "Increase Up"; }
          bind "l" "Right" { Resize "Increase Right"; }
          bind "H" { Resize "Decrease Left"; }
          bind "J" { Resize "Decrease Down"; }
          bind "K" { Resize "Decrease Up"; }
          bind "L" { Resize "Decrease Right"; }
          bind "=" "+" { Resize "Increase"; }
          bind "-" { Resize "Decrease"; }
        }
        tmux {
          bind "Esc" { SwitchToMode "Normal"; }
          bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
          bind "c" { NewTab; SwitchToMode "Normal"; }
          bind "[" { SwitchToMode "Scroll"; }
          bind "p" { SwitchToMode "Pane"; }
          bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
          bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "," { SwitchToMode "RenameTab"; }
          bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
          bind "o" { FocusNextPane; }
          bind "d" { Detach; }
          bind "s" { SwitchToMode "Session"; }
          bind "m" { SwitchToMode "Move"; }
          bind "Space" { NextSwapLayout; }
          bind "x" { CloseFocus; SwitchToMode "Normal"; }
          bind "r" { SwitchToMode "Resize"; }
        }
      }
    '';
  };
}
