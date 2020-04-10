#!/usr/bin/env bash
PID=$(xdotool getactivewindow getwindowpid)
for item in $(pidof emacs)
do
    if [ "$PID" == "$item" ]; then
        xdotool key --clearmodifiers Meta_L+w
        exit
    fi
done
xdotool key --clearmodifiers Control_L+c
