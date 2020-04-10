#!/usr/bin/env bash

xrandr --setprovideroutputsource 1 0

#xrandr --setprovideroutputsource 2 0
#xrandr --setprovideroffloadsink 1 0
#xrandr --setprovideroffloadsink 2 0

xrandr --output DVI-1-0 --auto
xrandr --output DVI-1-0 --pos 0x56



xrandr --output DVI-0 --auto
xrandr --output DVI-0 --pos 1280x0
xrandr --output VGA-0 --off
xrandr --output VGA-0 --auto
xrandr --output VGA-0 --pos 3200x56
xrandr --output VGA-0 --primary

#xrandr --output HDMI-1-0 --auto
#xrandr --output HDMI-1-0 --right-of DVI-0
#xrandr --output DVI-1-1 --auto
#xrandr --output DVI-1-1 --right-of HDMI-1-0
#xrandr --output VGA-0 --right-of DVI-1-1



#xrandr --newmode "1280x1024_60.00"  108.88  1280 1360 1496 1712  1024 1025 1028 1060  -HSync +Vsync
#xrandr --addmode DVI-2-0 1280x1024
#xrandr --output DVI-1-0 --mode 1280x1024

#xrandr --output DVI-2-1 --right-of VGA-0
#xrandr --output VGA-0 --primary
#xrandr --output DVI-0 --right-of DVI-2-1

