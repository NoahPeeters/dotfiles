if [ -z "$DISPLAY" ]; then
  (pulseaudio --start && shairport-sync)&
  startx
fi
