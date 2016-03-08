#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

simpleDate=`date +%F`

cd  $basedir/tpch_2_17_0
mkdir -p ./log_hive/$simpleDate/hyperdrive

for file  in `ls transwarp_queries`
do
  echo "$file"
  echo "" > /tmp/yarn/hive.log
  sql_name=`echo $file | awk -F '.' '{print $1}'` 
  juLog  -name=tpc-h-$sql_name    "sh run_hive2.sh -s $sql_name -d tpch_hyperdrive"
  cp /tmp/yarn/hive.log ./log_hive/$simpleDate/hyperdrive/${sql_name}-hive.log
done
  

