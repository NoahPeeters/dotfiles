#sqrt() {
#	local __resultvar=$1
#	local result=$(echo "sqrt($2)" | bc -l | cut -f1 -d".")
#	eval $__resultvar="'$result'"
#}
#
#sqrt backlight 255
#echo $backlight

while :
do
	raw=$(cat /sys/devices/platform/applesmc.768/light)
	raw=${raw%,0)}
	sensor=${raw:1}
	current=$(cat /sys/class/backlight/intel_backlight/brightness)
	
	kbd_backlight=$(( $sensor * 130 + 50))
	backlight=$(( ($sensor) * 355 ))
	
	if [ $sensor -gt 10 ]; then
		kbd_backlight=0
	fi
	
	if [ $backlight -lt 300 ]; then
		backlight=300
	elif [ $backlight -gt 1808 ]; then
		backlight=1808
	fi 

	x=1
	for i in $(eval echo {$current..$backlight}); do
		echo $i > /sys/class/backlight/intel_backlight/brightness
		sleep 0.01
		x=$(($x+1))
		if [ $x -gt 100 ]; then
			break
		fi
	done
	#echo $backlight > /sys/class/backlight/intel_backlight/brightness
	echo $kbd_backlight > /sys/class/leds/smc\:\:kbd_backlight/brightness

	#echo $sensor
	#echo $backlight
	#echo $kbd_backlight
	#echo -----------

	#sleep 5
done
