#!/bin/sh

cd
#used=`df -h . | awk '{print $5}' | sed -n '2p' | sed 's/%//g'`

exit_code=1

# status
minFS=""
minSize=""
minUsed=""
minAvail=""
minUsage=100
minMounted=""

for disk in `df -h | awk '{print $6}' | awk '/mnt/'|sed '1i /'`
do
  #echo '***********'
  cd $disk
  usage=`df -h . | awk '{print $5}' | sed -n '2p' | sed 's/%//g'`
  if [ $usage -lt $minUsage ]; then
    minUsage=$usage
    minFS=`df -h . | awk '{print $1}' | sed -n '2p'`
    minSize=`df -h . | awk '{print $2}' | sed -n '2p'`
    minUsed=`df -h . | awk '{print $3}' | sed -n '2p'`
    minAvail=`df -h . | awk '{print $4}' | sed -n '2p'`
    minMounted=$disk
  fi
done
#echo "Max Usage: $maxUsage"

if [ $minUsage -lt 85 ]; then
  echo ">>> The least used DISK $minFS on $minMounted is $minUsage% used (Size:$minSize, Used:$minUsed, Avail:$minAvail)
>>> safe regression "
  exit_code=0;
elif [ $miniUsage -lt 95 ];then
  echo ">>>The least used DISK $minFS on $minMounted is $minUsage% used (Size:$minSize, Used:$minUsed, Avail:$minAvail)
>>> WARNING! could be overload "
  exit_code=0;
else
  echo ">>> The least used DISK $minFS on $minMounted is $minUsage% used (Size:$minSize, Used:$minUsed, Avail:$minAvail)
>>> overload range."
fi

echo "------- Full Usage Report -------"
df -h

exit $exit_code

