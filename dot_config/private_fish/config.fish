if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
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
abbr -a czcd chezmoi cd
abbr -a czed chezmoi edit
abbr -a czgt chezmoi git

# homebrew
abbr -a bb brew bundle --global

# zellij
abbr -a z zellij -l welcome


zoxide init --cmd c fish | source
fzf --fish | source # fzf keybindings


source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish
