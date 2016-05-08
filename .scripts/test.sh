#while true; do
#	x=$( ip a | grep bnep0 )
#	if [ $? -eq 0 ]; then 
#		echo "bnep0 is up!"
#		dhcpcd bnep0
#		break
#	fi
#done
timeout 5 bash -c -- 'while true; do
                x=$( ip a | grep bnep0 )
                if [ $? -eq 0 ]; then
                        break
                fi
        done'
        timeout=$?
echo $timeout
