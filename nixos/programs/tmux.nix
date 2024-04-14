{ configs, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    tmuxinator = {
      enable = true;
    };
    aggressiveResize = true;
    prefix = "C-b";
    keyMode = "vi";
    shell = "\${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.extrakto
      tmuxPlugins.yank
      tmuxPlugins.jump
      {
        plugin = tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-key U
          set -g @thumbs-reverse enabled
        '';
      }
    ];
    extraConfig = ''
      # BIND-KEY CTRL-Q ON REMOTE SESSION
      bind -n C-q send-prefix

      set -g status-keys emacs

      # SWITCHING PANES WITH ALT
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

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

      bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M
      bind -n WheelDownPane select-pane -t= \;                 send-keys -M

      bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'

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

      set -g  xterm-keys on
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g  history-limit 20000
      set -g  buffer-limit  20
      set -g  set-titles on
      set -g  set-titles-string "#I:#W"
      set -g  base-index 1
      setw -g pane-base-index 1

      # DISPLAY TMUX MESSAGES LONGER
      set  -g display-time 4000
      set  -g display-panes-time 800

      # ADDRESS VIM-MODE SWITCHING DELAY (HTTP://SUPERUSER.COM/A/252717/65504)
      set -s  escape-time   0
      set -sg repeat-time   300
    '';
  };
}
