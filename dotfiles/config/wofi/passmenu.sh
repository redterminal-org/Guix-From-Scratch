#!/usr/bin/env bash

shopt -s nullglob globstar

prefix="$HOME/.password-store"

files=("$prefix"/**/*.gpg)
files=("${files[@]#"$prefix"/}")
files=("${files[@]%.gpg}")

password=$(
  printf '%s\n' "${files[@]}" |
    wofi --dmenu --prompt "Account"
)

[ -n "$password" ] || exit 0

value=$(pass show "$password" 2>/dev/null | head -n 1)

[ -n "$value" ] || exit 1

printf '%s' "$value" | wl-copy --trim-newline
