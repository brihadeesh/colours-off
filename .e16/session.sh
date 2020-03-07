#!/bin/bash

# TODO: WTF to do here?!
BGR='#ABB0B7'

case "$1" in
	init)
		# nothing yet?
		hsetroot -solid '$BGR' & 
		;;
	start)
                # usual suspects
		numlockx on &
		unclutter &
		killall -q xclock
		xclock -strftime %H:%M -geometry 35x18+8+10 -render -face \
			'Source Code Pro:weight=Bold:pixelsize=10' -fg '#eeeed7' -bg '#ABB0B7' &
		killall -q redshift
		while pgrep -u $UID -x redshift >/dev/null; do sleep 1; done
		redshift -c $HOME/.config/redshift.conf &
		;;
	stop)
                # do blah
                # or do function stop
		;;
esac

