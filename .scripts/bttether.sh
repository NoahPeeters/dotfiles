service bluetooth start
hciconfig hci0 up
dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci0/dev_24_DF_6A_34_1F_9B org.bluez.Network1.Connect string:'nap'
echo "Waiting for device to become ready..."
sleep 10
dhcpcd bnep0

