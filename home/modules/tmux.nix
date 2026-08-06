{ pkgs, ... }: {
  programs.tmux = {

    enable = true;
    prefix = "M-a";
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    # Home Manager native plugin management
    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];

    extraConfig = ''
      # ── Custom Prefix Override ──
      unbind C-b
      unbind C-a
      unbind C-Space
      bind M-a send-prefix

      bind -N "Reload tmux config" r source-file ~/.config/tmux/tmux.conf \; display "Reloaded"

      # ── Terminal ──
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ag terminal-overrides ",*:Tc"
      set -as terminal-features ",xterm-kitty:RGB:hyperlinks:overline:usstyle:clipboard:strikethrough"
      set -g allow-passthrough on

      # ── General ──
      setw -g pane-base-index 1
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-interval 2
      set -g focus-events on
      set -g extended-keys on
      set -g extended-keys-format csi-u

      # ── Windows (tabs) ──
      bind -N "New window" c new-window -c "#{pane_current_path}"
      bind -N "Previous window" p previous-window
      bind -N "Next window" n next-window
      bind -N "Kill current window" x kill-window
      bind -N "Go to window 1" 1 select-window -t 1
      bind -N "Go to window 2" 2 select-window -t 2
      bind -N "Go to window 3" 3 select-window -t 3
      bind -N "Go to window 4" 4 select-window -t 4
      bind -N "Go to window 5" 5 select-window -t 5

      # ── Splits (panes) ──
      bind -N "Split horizontal (below)" S split-window -v -c "#{pane_current_path}"
      bind -N "Split vertical (right)" V split-window -h -c "#{pane_current_path}"
      bind -N "Kill current pane" X kill-pane

      # ── Pane navigation ──
      bind -N "Cycle pane" Tab select-pane -t :.+
      bind -N "Pane left" h select-pane -L
      bind -N "Pane down" j select-pane -D
      bind -N "Pane up" k select-pane -U
      bind -N "Pane right" l select-pane -R

      # ── Pane resize ──
      bind -N "Resize left" -r H resize-pane -L 5
      bind -N "Resize down" -r J resize-pane -D 5
      bind -N "Resize up" -r K resize-pane -U 5
      bind -N "Resize right" -r L resize-pane -R 5

      # ── Zoom ──
      bind -N "Toggle zoom" z resize-pane -Z

      # ── Help: show all bindings in a popup ──
      bind -N "Show keybinds" ? display-popup -E -w 80% -h 80% "tmux list-keys -N | sort | less -R"

      # ── Copy mode ──
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-no-clear "wl-copy"
      bind -T copy-mode-vi Enter send-keys -X cancel
      set -g @copy_mode_yank "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

      # ── Auto-hide status when focused on nvim ──
      set-hook -g after-select-window 'if -F "#{==:#{pane_current_command},nvim}" "set status off" "set status on"'
      set-hook -g after-select-pane 'if -F "#{==:#{pane_current_command},nvim}" "set status off" "set status on"'

      # ── Mode Default ──
      set -g @zvm_mode "INSERT"
      set -g @zvm_mode_color "#80a0ff"

      # ── Status line ──
      set -g status on
      set -g status-position bottom
      set -g status-justify "left"
      set -g status-left-length 200
      set -g status-right-length 200

      # ── Theme Colors ──
      set -g @col_bg "#303030"
      set -g @col_fg "#c6c6c6"
      set -g @col_sep "#808080"
      set -g @col_git "#a6e3a1"
      set -g @col_tab_off "#6c7086"
      set -g @col_tab_on "#79dac8"

      set -g status-style "bg=default,fg=#c6c6c6"
      setw -g pane-active-border-style "fg=#d183e8"
      setw -g pane-border-style "fg=#303030"
      # Left bubble
      set -g status-left ""
      set -ga status-left "#[fg=#{@zvm_mode_color}]#[bg=default]"
      set -ga status-left "#[fg=#080808]#[bg=#{@zvm_mode_color}]#[bold] #{@zvm_mode} "
      set -ga status-left "#[nobold]#[fg=#{@zvm_mode_color}]#[bg=#{@col_bg}]"
      set -ga status-left "#[fg=#{@col_fg}]#[bg=#{@col_bg}]  #S "
      set -ga status-left "#[fg=#{@col_sep}]#[bg=#{@col_bg}]│"
      set -ga status-left "#[fg=#{@col_fg}]#[bg=#{@col_bg}] #{s|/home/dweller|~|:pane_current_path} "
      set -ga status-left "#[fg=#{@col_sep}]#[bg=#{@col_bg}]│"
      set -ga status-left "#{W:#[fg=#{@col_tab_off}]#[bg=#{@col_bg}]   #W ,#[fg=#{@col_tab_on}]#[bg=#{@col_bg}]#[bold]   #W #[nobold]}"
      set -ga status-left "#[fg=#{@col_bg}]#[bg=default]"

      # Right bubble
      set -g status-right-length 400
      set -g status-right ""
      set -ga status-right "#[fg=#{@col_bg},bg=default]"
      set -ga status-right "#[fg=#{@col_fg},bg=#{@col_bg}] 󰝚 #(playerctl metadata --format '{{title}} — {{artist}}' 2>/dev/null | cut -c1-40) "
      set -ga status-right "#[fg=#{@col_bg},bg=default]"

      set -wg automatic-rename on
      set -wg automatic-rename-format "#{b:pane_current_command}"

      set -g window-status-format ""
      set -g window-status-current-format ""
      set -g window-status-separator ""

      # ── Pane borders ──
      setw -g pane-border-status off
      setw -g pane-border-lines single

      # ── Clear leftover root bindings ──
      unbind -n C-h
      unbind -n C-j
      unbind -n C-k
      unbind -n C-l
      unbind -n 'C-\'

      # ── Mouse passthrough for TUI apps ──
      bind -n WheelUpPane if-shell -F -t = "#{alternate_on}" \
      "send-keys -M" \
      "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
      bind -n WheelDownPane if-shell -F -t = "#{alternate_on}" \
      "send-keys -M" \
      "send-keys -M"
    '';

  };
}
