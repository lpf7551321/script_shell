#/bin/bash

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

simpleDate=`date +%F`

cd  $basedir/transwarp_tpcds/
mkdir -p ./log_hive/$simpleDate/cboExplainTest/
conf=config_cbo
test_name=`echo $conf | awk -F '_' '{print $2}'`

for i in {1..99}
do
  #echo "" > /tmp/yarn/hive.log
  sql_name=query${i}.sql
  if [ -e ./sql/cbo-explain-test/${sql_name} ]
  then
    echo ""
    echo ""
    echo "$sql_name exists, execute it now..."
    juLog  -name=tpc-ds-orc-${test_name}-${sql_name}    "./cboExplainTest.pl -i ./conf/config_cbo_orc -f $i -t cbo -l"
    juLog  -name=tpc-ds-mem-${test_name}-${sql_name}    "./cboExplainTest.pl -i ./conf/config_cbo_mem -f $i -t cbo -l" 
    if [ -e ./log_hive/$simpleDate//${sql_name}-hive.log ]
    then
      rm -f ./log_hive/$simpleDate/cboExplainTest/${sql_name}-hive.log
    fi
   #cp /tmp/yarn/hive.log ./log_hive/$simpleDate/cboExplainTest/${sql_name}-hive.log
  fi 
done 
