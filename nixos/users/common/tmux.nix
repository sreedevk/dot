{ pkgs, ... }:
let
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin
    {
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
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
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
      tmuxPlugins.jump
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.yank
    ];
    prefix = "C-b";
    baseIndex = 1;
    mouse = true;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
      bind -n C-q send-prefix
      set -g status-keys emacs

      # SWITCHING PANES WITH C-M
      bind -n C-M-h select-pane -L
      bind -n C-M-l select-pane -R
      bind -n C-M-k select-pane -U
      bind -n C-M-j select-pane -D

      # SCROLL USING M-u & M-d
      bind -n M-u copy-mode
      bind -T copy-mode-vi M-u send-keys -X halfpage-up
      bind -T copy-mode-vi M-d send-keys -X halfpage-down

      # RESIZING PANELS
      bind -n M-J resize-pane -D 5
      bind -n M-K resize-pane -U 5
      bind -n M-H resize-pane -L 5
      bind -n M-L resize-pane -R 5

      # CLEAR SESSION WINDOW WITH CTRL-L
      bind C-l send-keys -R \; clear-history

      # BUFFER COPY
      bind b choose-buffer
      bind B list-buffers
      bind p paste-buffer
      bind P run "xclip -selection clipboard -o | tmux load-buffer - ; tmux paste-buffer"

      # COPY MODE
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi Escape send-keys -X cancel
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind -T copy-mode-vi C-g send-keys -X cancel
      bind -T copy-mode-vi H send-keys -X start-of-line
      bind -T copy-mode-vi L send-keys -X end-of-line

      # MOUSE SUPPORT
      bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M
      bind -n WheelDownPane select-pane -t= \;                 send-keys -M

      # SOURCING CONFIG
      bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'

      # STATUS BAR
      set -g status on
      set -g status-style bg=default
      set -g status-interval 5
      set -g status-left-length 30
      set -g status-right-length 30
      set -g status-position bottom
      set -g status-justify centre
      set -g status-left '#[fg=green]λ: #[fg=cyan]#S'
      set -g status-right "#[fg=cyan]#(date +'%a %B %d %l:%M:%S %p')"
      set -g automatic-rename on
      set -g window-status-format "#[fg=blue]#I#[fg=default]:#{=-20:?window_name,#{window_name},#{?pane_current_path,#{b:pane_current_path},}}#F"
      set -g window-status-current-format "#[fg=yellow]#I#[fg=green]:#{=-20:?window_name,#{window_name},#{?pane_current_path,#{b:pane_current_path},)}}#[fg=default]#F#[fg=yellow]#[fg=default]"

      # MAKE IT PRETTY + SANE DEFAULTS
      set -g  default-command "${pkgs.zsh}/bin/zsh --login"
      set -g  xterm-keys on
      set -g  default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g  buffer-limit  20
      set -g  set-titles on
      set -g  set-titles-string "#I:#W"

      # DISPLAY TMUX MESSAGES LONGER
      set  -g display-time 4000
      set  -g display-panes-time 800

      # ADDRESS VIM-MODE SWITCHING DELAY (HTTP://SUPERUSER.COM/A/252717/65504)
      set -s  escape-time   0
      set -sg repeat-time   300
    '';
  };
}
