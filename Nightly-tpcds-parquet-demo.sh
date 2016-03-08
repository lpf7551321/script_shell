	#/bin/bash

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

simpleDate=`date +%F`

cd  $basedir/transwarp_tpcds/
mkdir -p ./log_hive/$simpleDate/orc
host=$(hostname)
simpleTime=$(date +%Y-%m-%d-%H-%M-%S)
database=$(head -n 1 ./conf/config_all | awk '{print $2}' | awk -F ';' '{print $1}')
uuid="${host}_${database}_${simpleTime}"

for conf in config_parquet
do
  test_name=`echo $conf | awk -F '_' '{print $2}'`
  for i in {1..99}
  do
    echo "" > /tmp/yarn/hive.log
    sql_name=query${i}.sql
    if [ -e ./sql/2g-test/${sql_name} ]; then
      echo $sql_name
      juLog  -name=tpc-ds-${test_name}-${sql_name}    "./tpcds-test-2g.pl -i ./conf/$conf -f $i -c"
      sleep 5
      if [ -e ./log_hive/$simpleDate/orc/${sql_name}-hive.log ]; then
        rm -f ./log_hive/$simpleDate/orc/${sql_name}-hive.log
      fi
      cp /tmp/yarn/hive.log ./log_hive/$simpleDate/orc/${sql_name}-hive.log
    else
      echo "$sql_name is temporarily removed from tpc-ds test."
    fi
  done 
done
