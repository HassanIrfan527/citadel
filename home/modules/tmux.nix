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
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'macchiato'
          set -g @catppuccin_window_status_style "rounded"

          set -g @catppuccin_window_text " #{b:pane_current_command}"
          set -g @catppuccin_window_current_text " #{b:pane_current_command}"
        '';
      }
      {
        plugin = extrakto;
        extraConfig = ''
          set -g @extrakto_key "tab" 
          set -g @extrakto_split_direction "p"
          set -g @extrakto_popup_size "65%"
        '';
      }
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

      # ── Windows & Panes (Unchanged) ──
      bind -N "New window" c new-window -c "#{pane_current_path}"
      bind -N "Previous window" p previous-window
      bind -N "Next window" n next-window
      bind -N "Kill current window" x kill-window
      bind -N "Go to window 1" 1 select-window -t 1
      bind -N "Go to window 2" 2 select-window -t 2
      bind -N "Go to window 3" 3 select-window -t 3
      bind -N "Go to window 4" 4 select-window -t 4
      bind -N "Go to window 5" 5 select-window -t 5

      bind -N "Split horizontal (below)" S split-window -v -c "#{pane_current_path}"
      bind -N "Split vertical (right)" V split-window -h -c "#{pane_current_path}"
      bind -N "Kill current pane" X kill-pane

      bind -N "Cycle pane" Tab select-pane -t :.+
      bind -N "Pane left" h select-pane -L
      bind -N "Pane down" j select-pane -D
      bind -N "Pane up" k select-pane -U
      bind -N "Pane right" l select-pane -R

      bind -N "Resize left" -r H resize-pane -L 5
      bind -N "Resize down" -r J resize-pane -D 5
      bind -N "Resize up" -r K resize-pane -U 5
      bind -N "Resize right" -r L resize-pane -R 5

      bind -N "Toggle zoom" z resize-pane -Z
      bind -N "Show keybinds" ? display-popup -E -w 80% -h 80% "tmux list-keys -N | sort | less -R"

      # ── Copy mode ──
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-no-clear "wl-copy"
      bind -T copy-mode-vi Enter send-keys -X cancel
      set -g @copy_mode_yank "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

      # ── Status line ──
      set -g status on
      set -g status-left ""
      set -g status-position top
      set -g status-left-length 200
      set -g status-right-length 200

      set -g status-right "#{E:@catppuccin_status_user}"
      set -agF status-right "#{E:@catppuccin_status_directory}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"

      set -g allow-rename off

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
