#!/bin/bash

STATE_FILE="/tmp/hypr_opacity_tag"
FADE_DELAY=0.05 # delay tiap langkah

set_tag() {
  for wid in $(hyprctl clients -j | jq -r '.[].address'); do
    hyprctl dispatch tagwindow "$1" address:$wid
  done
}

# Pastikan rule ada
hyprctl keyword windowrulev2 "unset, tag:dim"
hyprctl keyword windowrulev2 "opacity 0.97 0.97, tag:dim"

if [ -f "$STATE_FILE" ]; then
  STATE=$(cat "$STATE_FILE")
else
  STATE="off"
fi

if [ "$STATE" = "off" ]; then
  set_tag "dim"
  echo "on" >"$STATE_FILE"
  MESSAGE="92%"
else
  set_tag ""
  echo "off" >"$STATE_FILE"
  MESSAGE="100%"
fi

# Paksa refresh (refocus window aktif)
ACTIVE=$(hyprctl activewindow -j | jq -r '.address')
hyprctl dispatch focuswindow address:$ACTIVE

notify-send "Opacity" "$MESSAGE"
