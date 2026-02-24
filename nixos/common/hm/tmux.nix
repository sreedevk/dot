{ pkgs
, opts
, config
, ...
}:
let
  sessionizer   = import ./scripts/sessionizer.nix    { inherit pkgs;      };
  bwfzf         = import ./scripts/bwfzf.nix          { inherit pkgs;      };
  sshfzf        = import ./scripts/sshfzf.nix         { inherit pkgs;      };
  time          = import ./scripts/time.nix           { inherit pkgs opts; };

  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-super-fingers";
    version    = "unstable-2023-01-06";
    src        = pkgs.fetchFromGitHub {
      owner  = "artemave";
      repo   = "tmux_super_fingers";
      rev    = "2c12044984124e74e21a5a87d00f844083e4bdf7";
      sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.rose-pine;
        extraConfig = "set -g @rose_pine_variant 'main'";
      }
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
                      "new-session -d -s system -c '${builtins.getEnv "HOME"}'; switch-client -t system"

      # COPY MODE
      bind -T   copy-mode-vi v      send-keys -X begin-selection
      bind -T   copy-mode-vi C-v    send-keys -X rectangle-toggle
      bind -T   copy-mode-vi Escape send-keys -X cancel
      bind -T   copy-mode-vi y      send-keys -X copy-pipe-and-cancel 'wl-copy'
      bind -T   copy-mode-vi C-g    send-keys -X cancel
      bind -T   copy-mode-vi 0      send-keys -X start-of-line
      bind -T   copy-mode-vi $      send-keys -X end-of-line
      bind p       paste-buffer
      bind    C-p  choose-buffer
      bind    C-q  copy-mode
      bind -T copy-mode-vi C-q send-keys -X cancel

      # WORKFLOWS
      bind C-a neww ${pkgs.wiremix}/bin/wiremix
      bind C-c new-session
      bind C-e neww ${pkgs.neovim}/bin/nvim
      bind C-g neww ${pkgs.lazygit}/bin/lazygit
      bind C-f neww ${pkgs.nnn}/bin/nnn
      bind C-h neww ${config.programs.htop.package}/bin/htop
      bind C-o neww ${sessionizer}/bin/tmux-sessionizer
      bind C-r neww ${pkgs.newsboat}/bin/newsboat
      bind C-s neww ${sshfzf}/bin/ssh-fzf
      bind C-t neww ${pkgs.taskwarrior-tui}/bin/taskwarrior-tui
      bind C-u if-shell "tmux has-session -t system 2>/dev/null" \
                        "switch-client -t system" \
                        "new-session -d -s system -c '${builtins.getEnv "HOME"}'; switch-client -t system"
      bind C-w neww ${bwfzf}/bin/bwfzf
      bind C-v run-shell "wl-paste | tmux load-buffer - ; tmux paste-buffer"

      # MOUSE SUPPORT
      bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M
      bind -n WheelDownPane select-pane -t= \;                 send-keys -M

      # SOURCING CONFIG
      bind r source-file ~/.config/tmux/tmux.conf \; display '~/.config/tmux/tmux.conf sourced'

      # IRISH EXIT
      bind X kill-session

      # MODE KEYS
      set -g status-keys emacs
      set -g mode-keys vi

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
      set -g status-right "#[fg=cyan]#(${time}/bin/ttd)"
      set -g window-status-format "#[fg=blue]#I#[fg=default]:#{=-20:?window_name,#{window_name},#{?pane_current_path,#{b:pane_current_path},}}#F"
      set -g window-status-current-format "#[fg=yellow]#I#[fg=green]:#{=-20:?window_name,#{window_name},#{?pane_current_path,#{b:pane_current_path},)}}#[fg=default]#F#[fg=yellow]#[fg=default]"

      # MAKE IT PRETTY + SANE DEFAULTS
      set -g  default-command "${pkgs.zsh}/bin/zsh"
      set -g  xterm-keys on
      set -s  extended-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      set -g  buffer-limit  20
      set -g  set-titles on
      set -g  set-titles-string "#I:#W"
      set -g  remain-on-exit off
      set -g  @copy_use_osc52_fallback on
      set -g  allow-passthrough on
      set -g  exit-empty off
      set -g  detach-on-destroy off
      set -g  renumber-windows on
      set -g  monitor-activity on
      set -g  visual-activity off
      set -g  focus-events on

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

  programs.sesh = {
    enable = true;
    package = pkgs.sesh;
    enableAlias = false;
    enableTmuxIntegration = false;
    # tmuxKey = "q";
    icons = true;
    settings = { };
  };
}
