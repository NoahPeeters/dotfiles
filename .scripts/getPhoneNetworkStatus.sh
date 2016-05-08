#!/bin/bash
phoneIP=$(ip route show | grep default | awk '{ print $3 }')
echo "status" > .gpns.tmp
status=$(timeout 10 netcat $phoneIP 4321 < .gpns.tmp)
rm .gpns.tmp
level=$(echo $status | awk '{ print $2 }')
type=$(echo $status | awk '{ print $1 }')
#echo $type
#echo $level
[ "$level" == "" ] && exit
if [ "$level" -gt 0 ]; then
	[ "$1" == level ] && echo "$level " || echo "$type"
fi
