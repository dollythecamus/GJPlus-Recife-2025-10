#!/bin/sh
printf '\033c\033]0;%s\a' SOMBRE ASTRA
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Linux - SOMBRE ASTRA" "$@"
