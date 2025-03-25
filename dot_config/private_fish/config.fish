if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set_theme
end

fish_add_path /opt/homebrew/bin
fish_add_path /Users/LukeJoshua/.rd/bin

set -x EDITOR nvim
set -x SHELL fish
set -x XDG_CONFIG_HOME "$HOME/.config"

# eza
set -x EZA_CONFIG_DIR ~/.config/eza

set -x NODE_EXTRA_CA_CERTS ~/zscaler_root_ca.cer

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

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

zoxide init --cmd c fish | source
fzf --fish | source # fzf keybindings
batman --export-env | source
