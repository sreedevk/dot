{ pkgs
, opts
, username
, ...
}:
let
  bitwaden-fzf-script = import ./bwfzf.nix { inherit pkgs; };
  tmux-sessionizer-script = import ./tmux-sessionizer.nix { inherit pkgs; };
  ssh-fzf-script = pkgs.writeShellScriptBin "ssh-fzf" ''
    server=$(grep -E '^Host ' ~/.ssh/config | awk '{print $2}' | fzf)
    if [[ -n $server ]] then
      ssh $server
    fi
  '';

  tmux-time-display = pkgs.writeShellScriptBin "ttd" ''
    TZ=${opts.timeZone} date "+%a %B %d %l:%M:%S %p"
  '';

  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-super-fingers";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "artemave";
      repo = "tmux_super_fingers";
      rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
      sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      {
        plugin = tmux-super-fingers;
        extraConfig = "set -g @super-fingers-key f";
      }
      {
        plugin = tmuxPlugins.extrakto;
        extraConfig = ''
          set -g @extrakto_key tab
          set -g @extrakto_copy_key	enter
          set -g @extrakto_insert_key	tab
          set -g @extrakto_filter_key ctrl-f
        '';
      }
      {
        plugin = tmuxPlugins.jump;
        extraConfig = ''
          set -g @jump-key 'o'
          set -g @jump-keys-position 'left'
        '';
      }
      {
        plugin = tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-key space
        '';
      }
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @custom_copy_command 'wl-copy'
        '';
      }
    ];
    prefix = "C-b";
    baseIndex = 1;
    mouse = true;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
      # SWITCHING PANES
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      # SCROLL USING M-u & M-d
      bind -T copy-mode-vi M-u send-keys -X halfpage-up
      bind -T copy-mode-vi M-d send-keys -X halfpage-down

      # RESIZING PANELS
      bind J resize-pane -D 5
      bind K resize-pane -U 5
      bind H resize-pane -L 5
      bind L resize-pane -R 5

      # CLEAR SESSION WINDOW WITH CTRL-L
      bind C-l send-keys -R \; clear-history

      # SWITCH SESSIONS
      bind -r \\ switch-client -l
      bind -r b  switch-client -n
      bind -r B  switch-client -p
      bind | if-shell "tmux has-session -t system 2>/dev/null" \
                      "switch-client -t system" \
                      "new-session -d -s system -c '/home/${username}'; switch-client -t system"

      # COPY MODE
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi Escape send-keys -X cancel
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
      bind -T copy-mode-vi C-g send-keys -X cancel
      bind -T copy-mode-vi 0 send-keys -X start-of-line
      bind -T copy-mode-vi $ send-keys -X end-of-line
      bind p  paste-buffer
      bind C-p choose-buffer

      # TMUX SESSIONIZER
      bind C-o run-shell "tmux neww ${tmux-sessionizer-script}/bin/tmux-sessionizer"

      # BWFZF
      bind C-w run-shell "tmux neww ${bitwaden-fzf-script}/bin/bwfzf"

      # TASKWARRIOR
      bind C-t run-shell "tmux neww ${pkgs.taskwarrior-tui}/bin/taskwarrior-tui"

      # SSH
      bind C-s run-shell "tmux neww ${ssh-fzf-script}/bin/ssh-fzf"

      # NEMO
      bind C-n run-shell "setsid nemo \"#{pane_current_path}\" >/dev/null 2>&1 &"

      # NSXIV
      bind C-i run-shell "setsid ${pkgs.nsxiv}/bin/nsxiv -r \"#{pane_current_path}\" >/dev/null 2>&1 &"

      # MOUSE SUPPORT
      bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M
      bind -n WheelDownPane select-pane -t= \;                 send-keys -M

      # SOURCING CONFIG
      bind r source-file ~/.config/tmux/tmux.conf \; display '~/.config/tmux/tmux.conf sourced'

      # IRISH EXIT
      bind X kill-session

      # MODE KEYS
      set -g status-keys emacs
      set -g mode-keys   vi

      # CLEAN UP VI MODE
      unbind C-,
      unbind C-.

      # STATUS BAR
      set -g status on
      set -g status-style bg=default
      set -g status-interval 5
      set -g status-left-length 30
      set -g status-right-length 30
      set -g status-position bottom
      set -g status-justify centre
      set -g status-left '#[fg=green]λ: #[fg=cyan]#S'
      set -g status-right "#[fg=cyan]#(${tmux-time-display}/bin/ttd)"
      set -g window-status-format "#[fg=blue]#I#[fg=default]:#{=-20:?window_name,#{window_name},#{?pane_current_path,#{b:pane_current_path},}}#F"
      set -g window-status-current-format "#[fg=yellow]#I#[fg=green]:#{=-20:?window_name,#{window_name},#{?pane_current_path,#{b:pane_current_path},)}}#[fg=default]#F#[fg=yellow]#[fg=default]"

      # MAKE IT PRETTY + SANE DEFAULTS
      set -g  default-command "${pkgs.zsh}/bin/zsh --login"
      set -g  xterm-keys on
      set -s  extended-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g  buffer-limit  20
      set -g  set-titles on
      set -g  set-titles-string "#I:#W"
      set -g  remain-on-exit off
      set -g  @copy_use_osc52_fallback on
      set -g allow-passthrough on

      setw -g allow-rename on
      setw -g automatic-rename on
      setw -g aggressive-resize on

      # DISPLAY TMUX MESSAGES LONGER
      set  -g display-time 1500
      set  -g display-panes-time 800

      # HOOKS
      # set-hook -g after-new-window 'command-prompt -I "#{window_name}" "rename-window '%%'"'

      # ADDRESS VIM-MODE SWITCHING DELAY (HTTP://SUPERUSER.COM/A/252717/65504)
      set -s  escape-time   0
      set -sg repeat-time   300
    '';
  };
}
