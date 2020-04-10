#!/bin/sh
#setxkbmap hazi
xkbcomp 1mary.xkb -i 14 $DISPLAY
xkbcomp 2ndary.xkb -i 13 $DISPLAY

xset r rate 200 60

xcape -e "Shift_L=Shift_L|9;Shift_R=Shift_R|0"
