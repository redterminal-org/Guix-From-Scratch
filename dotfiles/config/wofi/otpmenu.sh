#!/usr/bin/env bash

shopt -s nullglob globstar

prefix="$HOME/.password-store/otp"

files=("$prefix"/**/*.gpg)
files=("${files[@]#"$prefix"/}")
files=("${files[@]%.gpg}")

otp=$(
  printf '%s\n' "${files[@]}" |
    wofi --dmenu --prompt "OneTimePass"
)

[ -n "$otp" ] || exit 0

value=$(pass otp code "otp/$otp" 2>/dev/null)

[ -n "$value" ] || exit 1

printf '%s' "$value" | wl-copy --trim-newline
