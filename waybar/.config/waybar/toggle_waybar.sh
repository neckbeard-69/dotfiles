
#!/bin/bash

WAYBAR_ID=$(pgrep waybar)

if [ -z "$WAYBAR_ID" ]; then
    exit 1
fi

if xprop -name "waybar" | grep -q "hidden"; then
    xdotool search --name "waybar" windowmap
    xprop -name "waybar" -f _NET_WM_STATE 32a -set _NET_WM_STATE ""
else
    xdotool search --name "waybar" windowunmap
    xprop -name "waybar" -f _NET_WM_STATE 32a -set _NET_WM_STATE "hidden"
fi
