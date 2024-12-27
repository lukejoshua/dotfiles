if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set_theme
end

set -x EDITOR nvim
set -x SHELL fish

# git
abbr -a gst git status
abbr -a lg lazygit

# neovim
abbr -a n nvim

# chezmoi
abbr -a cz chezmoi

# homebrew
abbr -a bb brew bundle --global

# zellij
abbr -a z zellij -l welcome


zoxide init --cmd c fish | source
fzf --fish | source # fzf keybindings
batman --export-env | source


source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish
