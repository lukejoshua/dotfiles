if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set_theme
end

set -x EDITOR nvim
set -x SHELL fish

# eza
set -x EZA_CONFIG_DIR ~/.config/eza
# set -x EZA_MIN_LUMINANCE 60
abbr -a l eza
abbr -a la eza --long --header --color-scale --all --time-style relative --no-permissions --no-user --git --git-repos
abbr -a lt eza --tree --level=3 --long --header --color-scale --all --time-style relative --no-permissions --no-user --git --git-repos

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

source ~/.asdf/asdf.fish
