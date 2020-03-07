#!/bin/sh

# this file is executed when calling startx

# to start a different WM, set session="WM" below, or in console run:
#    startx ~/.xinitrc WM

# session to run if none passed as first arg ($1)
session="${1:-e16}"

# set environment wm for use in scripts
export WM="$session"

# default arch xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# user init scripts and settings
[ -f /etc/X11/xinit/.Xmodmap ] && xmodmap /etc/X11/xinit/.Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && source ~/.xprofile

# display timeout and sleep
xset s 3600 3600
xset dpms 3600 3700 4000

# keyboard repeat rate
xset r rate 400 50
kbdrate -d 400 -r 50

# dbus
dbus-update-activation-environment --all
dbus-launch

## pywal restore last theme
#wal -R

# do NOT put commands below the exec lines
case $session in

    dwm) exec $HOME/.dwm/startdwm.sh ;;

    hlwm) exec herbstluftwm --locked ;;

    e16) exec e16 ;;

    *)          exec "$session" # Unknown, try running it
esac
