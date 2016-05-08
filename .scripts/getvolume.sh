#!/bin/bash
raw=$(pactl list | grep "	Sink: " | sed "s/[^0-9]//g;s/^$/-1/;")
sinks=($raw)
output=""
x=0
for key in "${!sinks[@]}"
do
	sink="${sinks[$key]}"
	vol=$($HOME/.scripts/getvolume.pl $sink)
	if [ "${#sinks[@]}" -gt "1" ] && [ "$key" -gt "0" ]; then
		output="$output  "
		#output="$output$sink: "
	fi
	output="$output  $vol"
done
if [ "$BLOCK_BUTTON" != "" ]; then pavucontrol; fi
echo $output
