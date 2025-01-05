function conf --description "select a chezmoi-managed config file to edit"
    set -l hint $argv[1]
    set -l chezmoi_target (chezmoi managed --exclude dirs | fzf --scheme=path --query="$hint" --select-1 --tiebreak=end --border=none --preview-window=border-none --no-info --reverse --preview '
        set -l filename ~/{}
        if not test -e $filename
            set filename (chezmoi source-path {})
        end
        bat --force-colorization -pp $filename
    ') && chezmoi edit --apply ~/$chezmoi_target
end
