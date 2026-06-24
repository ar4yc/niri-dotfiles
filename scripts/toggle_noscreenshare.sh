#!/bin/bash

CONFIG_FILE="$HOME/.config/niri/windowrules/windowapps.kdl"
STATE_FILE="$HOME/.config/niri/scripts/.screenshare_rule_disabled"

toggle_rule() {
    if [ -f "$STATE_FILE" ]; then
        sed -i 's|^\([[:space:]]*\)//[[:space:]]*\(.*block-out-from.*\)$|\1\2|' "$CONFIG_FILE"
        rm -f "$STATE_FILE"
        CLASS="on"
    else
        sed -i 's|^\([[:space:]]*\)\(.*block-out-from.*\)$|\1// \2|' "$CONFIG_FILE"
        touch "$STATE_FILE"
        CLASS="off"
    fi
}

case ${1} in
    "toggle")
        toggle_rule
        ;;
    *)
        if [ -f "$STATE_FILE" ]; then
            CLASS="off"
        else
            CLASS="on"
        fi
        ;;
esac

echo "{\"class\": \"$CLASS\", \"alt\": \"$CLASS\"}"