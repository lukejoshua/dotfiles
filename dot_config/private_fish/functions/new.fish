function new
    set -l argc (count $argv)
    set -l subcommands function dotfile
    set -f subcommand

    if test $argc -eq 0
        # No subcommand, so select a subcommand
        set subcommand (string split ' ' $subcommands | fzf)
    else
        set subcommand $argv[1]
    end

    if test -z $subcommand
        echo No subcommand selected
        return
    end

    if not contains $subcommand $subcommands
        echo Unknown subcommand: $subcommand
        return
    end

    switch $subcommand
        case function
            echo Create new fish function
        case dotfile
            echo Create new dotfile
    end
end

function select

end
