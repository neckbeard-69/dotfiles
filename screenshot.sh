#!/bin/bash

OUTPUT_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"

if [[ ! -d "$OUTPUT_DIR" ]]; then
    mkdir -p ~/Pictures
fi

TEMP_FILE="$(mktemp /tmp/screenshot-XXXXXX.png)"

grim -g "$(slurp)" "$TEMP_FILE"

satty --filename "$TEMP_FILE" \
  --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
  --early-exit \
  --actions-on-enter save-to-clipboard \
  --save-after-copy \
  --copy-command 'wl-copy'

rm -f "$TEMP_FILE"
