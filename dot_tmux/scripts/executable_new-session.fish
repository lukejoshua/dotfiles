#!/usr/bin/env fish

# Use zoxide to select a directory
set selected_dir (zoxide query -i)

if test -z "$selected_dir"
    echo "No directory selected"
    return 1
end

# Prompt the user to enter a session name
read --prompt-str "Enter session name: " session_name
if test -z "$session_name"
    echo "Session name is required."
    return 1
end

# Check if session already exists
if tmux has-session -t "$session_name" ^/dev/null
    echo "Session '$session_name' already exists"
    tmux switch-client -t "$session"
    return
end

# Create new tmux session detached
tmux new-session -d -s "$session_name" -c "$selected_dir" -n "vim:$session_name"

# Create second window
tmux new-window -t "$session_name" -n "dev:$session_name" -c "$selected_dir"

# Set default-path for the session so new panes/windows inherit it
tmux set-option -t "$session_name" default-path "$selected_dir"

# Attach to the session
tmux switch-client -t "$session"
