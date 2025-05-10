#!/usr/bin/env fish

# List all tmux sessions and allow the user to select one via fzf
set session (tmux list-sessions -F "#{session_name}" | rg --invert-match "^$(tmux display-message -p '#S')\$" | fzf --prompt="Select session: ")

# If a session was selected, switch to it
if test -n "$session"
    tmux switch-client -t "$session"
end
