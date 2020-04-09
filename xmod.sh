#!/bin/sh
#setxkbmap hazi
xkbcomp hazi.xkb $DISPLAY
#xmodmap -e "remove  mod4 = Hyper_L"
#xmodmap -e "remove  mod4 = Hyper_R"
#xmodmap -e "add  mod3 = Hyper_L"
#xmodmap -e "remove  mod2 = Num_Lock"
#xmodmap -e "remove  mod4 = Meta_R"
#xmodmap -e "remove  mod4 = Meta_L"
#xmodmap -e "add mod2 = Meta_R"
#xmodmap -e "add mod2 = Meta_L"
#xmodmap -e "add mod4 = Menu"

xset r rate 200 60

/usr/sbin/actkbd -D -d /dev/input/by-id/usb-LITE-ON_Technology_USB_NetVista_Full_Width_Keyboard.-event-kbd -c ~/dotfiles/actkbd.conf
