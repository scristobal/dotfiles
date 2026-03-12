#!/usr/bin/env bash
# Claude Code status line — mirrors Starship prompt style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Shorten home directory to ~
short_dir="${cwd/#$HOME/\~}"

# Git info (skip locks to stay fast and non-blocking)
git_branch=""
git_dirty=""
if git_branch_raw=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null); then
    git_branch="$git_branch_raw"
    if ! git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null; then
        git_dirty="*"
    fi
fi

# Build the status line
parts=()

# directory (blue)
parts+=("$(printf '\033[34m%s\033[0m' "$short_dir")")

# git branch + dirty indicator (bright-black / cyan)
if [ -n "$git_branch" ]; then
    branch_str="$(printf '\033[90m%s\033[0m' "$git_branch")"
    if [ -n "$git_dirty" ]; then
        branch_str+="$(printf '\033[36m%s\033[0m' "(*)")"
    fi
    parts+=("$branch_str")
fi

# model (dim)
if [ -n "$model" ]; then
    parts+=("$(printf '\033[2m%s\033[0m' "$model")")
fi

# context remaining (yellow if low, otherwise dim)
if [ -n "$remaining" ]; then
    pct=$(printf '%.0f' "$remaining")
    if [ "$pct" -le 20 ]; then
        ctx_str="$(printf '\033[33mctx:%s%%\033[0m' "$pct")"
    else
        ctx_str="$(printf '\033[2mctx:%s%%\033[0m' "$pct")"
    fi
    parts+=("$ctx_str")
fi

# Join parts with a space separator
printf '%s' "${parts[0]}"
for part in "${parts[@]:1}"; do
    printf ' %s' "$part"
done
printf '\n'
