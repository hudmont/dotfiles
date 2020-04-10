#!/usr/bin/env bash
PID=$(xdotool getactivewindow getwindowpid)
for item in $(pidof emacs)
do
    if [ "$PID" == "$item" ]; then
        rofi -e $PID $item
        xdotool key --clearmodifiers Control_L+w
        exit
    fi
done
xdotool key --clearmodifiers Control_L+x
