#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

sh ~/.fehbg &
xbindkeys
unclutter &
redshift &
avahi-browse _dacp._tcp -rplfk | avahi-browse_parser &
LATENCY=30000
(pulseaudio --start && shairport-sync --latency=$LATENCY -i=$LATENCY -A=$LATENCY -vv 2>&1 | shairport_parser)&
devmon --no-gui &
numlockx &

#xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &
#perl ~/.xSwipe/xSwipe.pl -n -d 0.5 1>/dev/null 2>&1 &
exec i3
