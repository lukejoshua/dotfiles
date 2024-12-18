
function fish_prompt
    echo (set color normal) "❯ "
end

function fish_right_promt
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
    end

    echo -n -s (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal


end
