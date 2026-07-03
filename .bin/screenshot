#!/usr/bin/env fish

set satty_args \
    -f - \
    --copy-command wl-copy \
    -o "$HOME/Pictures/Screenshots/%Y%m%d_%H%M%S.png"

if test "$argv[1]" = "full"
    grim - | satty $satty_args
    exit 0
end

set region (slurp); or exit 0

grim -g "$region" - | satty $satty_args
