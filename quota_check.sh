#############################################
# Name: quota_check.sh
# Desc: Very simple disk quota check on current server
# Writer: lin.lv@transwarp.io
#############################################

#!/bin/sh

cd /
used=`df -h . | awk '{print $5}' | sed -n '2p' | sed 's/%//g'`

if [ $used -gt 95 ]; then
  echo ">>> DISK USAGE is $used%, STOP regression !!!"
  exit 1;
fi

if [ $used -gt 90 ]; then
  echo ">>> DISK USAGE is $used%, almost FULL, clean your regression output!"
fi

if [ $used -gt 80 ]; then
  echo ">>> DISK USAGE is $used%, be cautious of the potential risk!"
fi

if [ $used -lt 80 ]; then
  echo ">>> DISK USAGE is $used%, safe range."
fi


