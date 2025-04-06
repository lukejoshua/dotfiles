#!/usr/bin/env fish

function git_branch_status
    # Force color output regardless of terminal
    set -x TERM xterm-256color
    git config --local color.ui always

    # Store the current branch name
    set current_branch $argv[1]

    if test -z "$current_branch"
        set current_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    end

    if test -z "$current_branch"
        echo "Not in a git repository!"
        return 1
    end

    # Summary line with total commits, branches, and contributors in the last 90 days
    set total_commits (git rev-list --count --since="90 days ago" HEAD 2>/dev/null)
    set active_branches_count 0
    for branch in (git for-each-ref --format='%(refname:short)' refs/heads/)
        set branch_commits (git rev-list --count --since="90 days ago" $branch 2>/dev/null)
        if test $branch_commits -gt 0
            set active_branches_count (math $active_branches_count + 1)
        end
    end
    set total_contributors (git shortlog -sn --since="90 days ago" 2>/dev/null | wc -l | string trim)

    echo (set_color --bold blue)"📈 Activity Summary (90 days):"(set_color normal)" "(set_color yellow)$total_commits(set_color normal)" commits, "(set_color yellow)$active_branches_count(set_color normal)" active branches, "(set_color yellow)$total_contributors(set_color normal)" contributors"
    echo ""

    # Show recent contributors (last 90 days instead of using --since which doesn't work with for-each-ref)
    echo (set_color --bold blue)"📊 Recent Contributors (90 days):"(set_color normal)
    set ninety_days_ago (date -v-90d +%s 2>/dev/null; or date --date="90 days ago" +%s 2>/dev/null; or date -d "-90 days" +%s 2>/dev/null)
    git shortlog -sn --no-merges --since="90 days ago" 2>/dev/null | while read line
        set count (echo $line | awk '{print $1}')
        set name (echo $line | awk '{$1=""; print $0}' | string trim)
        echo "   (set_color yellow)$count(set_color normal) commits by (set_color magenta)$name(set_color normal)"
        # echo "   "(set_color yellow)$count(set_color normal)" commits by "(set_color magenta)$name(set_color normal)
    end
    echo ""


    # Show information about current branch
    echo (set_color --bold blue)"📋 Recent commits:"(set_color normal)
    # Last 5 commits on current branch
    git log -5 --pretty=format:"   %C(yellow)%h %C(cyan)%ad%C(auto) %C(reset)%s %C(magenta)@%an" --date=relative $current_branch
    echo ""

    # Optional: GitHub PR information (placed at the end as requested)
    if type -q gh
        echo (set_color --bold blue)"🔄 Recent GitHub PRs (may take a moment):"(set_color normal)
        gh pr list --state merged --limit 10 --json number,title,mergedAt,author --template \
            '{{range .}}   #{{.number}}: "{{.title}}" by {{.author.login}} ({{timeago .mergedAt}}){{println}}{{end}}' 2>/dev/null
        or echo "   GitHub CLI not configured properly or repository is not linked to GitHub"
        echo ""
    end
end
