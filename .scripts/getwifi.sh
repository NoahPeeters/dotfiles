[[ -z "$(iwgetid -r)" ]] || echo "$(iwgetid -r) "

if [ "$BLOCK_BUTTON" == "1" ]; then
   urxvt -e sudo nano /etc/wpa_supplicant/wpa_supplicant.conf &
fi
