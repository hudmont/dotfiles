#!/bin/sh
setxkbmap -device 8 hazi2

setxkbmap -device 14 hazi

# -option altwin:left_meta_win
#-option altwin:left_meta_win

#xmodmap -e 'remove Mod2 = Alt_L'
#xmodmap -e 'remove Mod2 = Alt_L'
xmodmap -e "clear mod1"
xmodmap -e 'add Mod1 = Alt_L'

####xmodmap -e 'remove Mod2 = Alt_L'
#xmodmap -e 'remove Mod1 = Meta_L'

#####xmodmap -e 'add Mod2 = Meta_L'

#####xmodmap -e 'remove Mod1 = Meta_R'

#####xmodmap -e 'remove Mod4 = Meta_L'
#####xmodmap -e 'remove Mod4 = Meta_R'
#xmodmap -e 'remove Mod1 = Meta_L'
xmodmap -e 'add Mod2 = Meta_L'
#xmodmap -e 'add Mod2 = Meta_R'
xmodmap -e 'remove Mod4 = Hyper_L'
xmodmap -e 'add Mod3 = Hyper_L'
#xmodmap -e 'add Mod3 = Hyper_R'




