#!/usr/bin/env bash

CATEGORIES=(
	"WORK"
	"WASTE"
	"STOP"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | fzf)

if [[ "$selected" == "STOP" ]]; then
	timew stop
	tmux set -g status-right ""
else
	timew start "$selected"
	tmux set -g status-right "$selected #(timew | awk '/^ *Total/ {print \$NF}')"
fi
