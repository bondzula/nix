{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sesh # use to manage the tmux sessions
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    escapeTime = 0;
    historyLimit = 5000;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
# ████████╗███╗   ███╗██╗   ██╗██╗  ██╗
# ╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝
#    ██║   ██╔████╔██║██║   ██║ ╚███╔╝
#    ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗
#    ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
#    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
# Terminal multiplexer
# https://github.com/tmux/tmux
set-option -g focus-events on # TODO: learn how this works

# TODO: find a way to toggle this?
set-option -g display-time 3000

# colors
set -g default-terminal "tmux-256color"
set -g terminal-overrides ",xterm-256color:RGB"

set -g base-index 1          # start indexing windows at 1 instead of 0
set -g detach-on-destroy off # don't exit from tmux when closing a session
set -g escape-time 0         # zero-out escape time delay
set -g history-limit 1000000 # increase history size (from 2,000)
set -g mouse on              # enable mouse support
set -g renumber-windows on   # renumber all windows when any window is closed
set -g set-clipboard on      # use system clipboard
set -g status-interval 3     # update the status bar every 3 seconds

set -g status-left "#[fg=blue,bold]#S"
set -ga status-left " #[fg=white,nobold]#(gitmux -cfg $HOME/.config/tmux/gitmux.yml)"
set -g status-left-length 200    # increase length (from 10)
set -g status-position top       # macOS / darwin style
set -g status-right ""           # blank
set -g status-style "bg=default" # transparent

set -g window-status-current-format "👉#[fg=magenta]#W"
set -g window-status-format "  #[fg=gray]#W"

set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM

set -g message-command-style bg=default,fg=yellow
set -g message-style bg=default,fg=yellow
set -g mode-style bg=default,fg=yellow
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'

bind '%' split-window -c '#{pane_current_path}' -h
bind '"' split-window -c '#{pane_current_path}'
bind c new-window -c '#{pane_current_path}'
# TODO: repeat this for all bindings
bind -N "⌘+g lazygit " g new-window -c "#{pane_current_path}" -n "🌳" "lazygit 2> /dev/null"
bind -N "⌘+G gh-dash " G new-window -c "#{pane_current_path}" -n "😺" "ghd 2> /dev/null"
bind B new-window -n '👷' b
bind D new-window -n '👷' d
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt (cmd+w)
bind-key e send-keys "tmux capture-pane -p -S - | nvim -c 'set buftype=nofile' +" Enter
bind-key "K" run-shell "sesh connect $(
	sesh list -H | fzf-tmux -p 50%,60% \
		--no-sort --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a all ^t tmux ^x zoxide ^f find ^d kill-session' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
)"

bind-key "Z" display-popup -E "sesh connect \$(sesh list | zf --height 24)"

set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
set -g @fzf-url-history-limit '2000'
set -g @t-bind 'T'
set -g @t-fzf-find-binding 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)'
set -g @t-fzf-prompt '🔭 '
set -g @tmux-last-color on
set -g @tmux-last-pager 'less -r'
set -g @tmux-last-pager 'less'
set -g @tmux-last-prompt-pattern ' '
set -g @tmux-nerd-font-window-name-shell-icon ''
set -g @tmux-nerd-font-window-name-show-name false
set -g @thumbs-command 'echo -n {} | pbcopy' # copy to clipboard
set -g @thumbs-key C
    '';
  };
}
