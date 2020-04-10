#!/usr/bin/env bash
PID=$(xdotool getactivewindow getwindowpid)
for item in $(pidof emacs)
do
    if [ "$PID" == "$item" ]; then
        xdotool key --clearmodifiers Control_L+x ;
        xdotool key --clearmodifiers u
        exit
    fi
done
xdotool key --clearmodifiers Control_L+z
