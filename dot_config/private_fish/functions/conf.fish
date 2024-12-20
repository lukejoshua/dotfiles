function conf --description "select a chezmoi-managed config file to edit"
    set -l chezmoi_target (chezmoi managed -p absolute -x dirs | fzf) && chezmoi edit $chezmoi_target
end
