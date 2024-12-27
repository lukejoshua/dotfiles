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
            read -l function_name -P "fish function name: "
            if test -z $function_name
                echo "No function name provided"
                return
            end

            if string match --regex ' ' $function_name
                echo "Invalid function name"
                return
            end

            set -l function_path ".config/fish/functions/$function_name.fish"

            if test -f $function_path
                echo "Function already exists"
                return
            end

            echo -e "function $function_name\n\nend" >(chezmoi source-path $function_path)
            chezmoi edit --apply $function_path

        case dotfile
            set -l dotfile_directories (chezmoi managed -i dirs)
            set -p dotfile_directories '.'
            set -l dotfile_directory (string split ' ' $dotfile_directories | fzf)

            if test -z $dotfile_directory
                echo "No directory selected"
                return
            end

            read -l dotfile_name -P "dofile name: "
            if test -z $dotfile_name
                echo "No dotfile name provided"
                return
            end

            set -l full_path "$dotfile_directory/$dotfile_name"

            mkdir -p (dirname $full_path)
            touch $full_path

            set -l chezmoi_path (string replace --regex "^$HOME/" '' $full_path)

            chezmoi add $chezmoi_path
            chezmoi edit $chezmoi_path --apply
    end
end

function select

end
