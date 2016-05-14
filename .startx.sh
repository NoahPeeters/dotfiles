if [ -z "$DISPLAY" ]; then
  (pulseaudio --start && shairport-sync)&
#  redshift&
  startx
fi
