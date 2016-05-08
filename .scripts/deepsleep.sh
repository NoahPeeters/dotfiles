#!/bin/bash
wakealarm=$(cat /sys/class/rtc/rtc0/wakealarm)
if [ "$wakealarm" == "" ]; then
	echo -n disk > /sys/power/state
fi
