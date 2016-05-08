#!/bin/bash

status=$(cat /etc/backup_info)

case $status in
  0)
    echo -e "\uf1da    "
    ;;
  1)
    echo -e "\uf017    "
    ;;
  2)
    echo -e "\uf05d    "
    ;;
esac
