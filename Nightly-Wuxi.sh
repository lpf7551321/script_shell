#/bin/bash

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd ./wuxi-test
rm -f ISsucessful.out
rm -f result
line=0;
cat wuxiSQL.sql |while read myline
do 
  line=$(($line+1))
  echo "$myline"
  juLog  -name=sql$line    "bash run.sh '${myline}' $line"
done
