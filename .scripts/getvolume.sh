#!/bin/bash
raw=$(pactl list | grep "	Sink: " | sed "s/[^0-9]//g;s/^$/-1/;")
sinks=($raw)
output=""
x=0
#echo ${!sinks[@]}
for key in "0"  #"${!sinks[@]}"
do
        #echo "$key"
	sink="${sinks[$key]}"
	vol=$($HOME/.scripts/getvolume.pl $sink)
	if [ "${#sinks[@]}" -gt "1" ] && [ "$key" -gt "0" ]; then
		output="$output  "
		#output="$output$sink: "
	fi
	output="$output  $vol"
done
if [ "$BLOCK_BUTTON" != "" ]; then
  pavucontrol &
#  gksudo wpa_gui &
#  whoami > /tmp/iam 
fi

#if [ "$BLOCK_BUTTON" != "" ]; then (gksu wpa_gui &); fi
echo $output
