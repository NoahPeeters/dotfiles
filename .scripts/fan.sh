#!/bin/bash

MAN_SPEED=$(cat /sys/devices/platform/applesmc.768/fan1_output)

if [ "$BLOCK_BUTTON" == "1" ]; then
  if [ $(cat /sys/devices/platform/applesmc.768/fan1_manual) -eq 0 ]; then
    echo "1" > /sys/devices/platform/applesmc.768/fan1_manual
  else
    echo "0" > /sys/devices/platform/applesmc.768/fan1_manual
  fi
elif [ "$BLOCK_BUTTON" == "4" ]; then
  if [ $MAN_SPEED -lt 6200 ]; then
    echo $(($MAN_SPEED+100)) > /sys/devices/platform/applesmc.768/fan1_output
  fi
elif [ "$BLOCK_BUTTON" == "5" ]; then
  if [ $MAN_SPEED -gt 2000 ]; then
    echo $(($MAN_SPEED-100)) > /sys/devices/platform/applesmc.768/fan1_output
  fi
fi



TEMP=$(sensors | grep Physical | sed s/"Physical id 0:"// | sed s/"°C  (high = +87.0°C, crit = +105.0°C)"// | tr -d ' ' | tr -d '+')

if [ $(cat /sys/devices/platform/applesmc.768/fan1_manual) -eq 0 ]; then
  echo "$TEMP-$(cat /sys/devices/platform/applesmc.768/fan1_input)"
else
  echo "$TEMP+$(cat /sys/devices/platform/applesmc.768/fan1_output)"
fi

