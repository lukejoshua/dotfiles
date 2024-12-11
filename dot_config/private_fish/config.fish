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

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix ')'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end

zoxide init --cmd c fish | source
fzf --fish | source # fzf keybindings


source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish
