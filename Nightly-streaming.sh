#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd /root/streaming/StreamingTest
./runjob.sh

cd /root/streaming/MockData
./mockdata.sh

juLog  -name=anhui-mem    "./run-mem.sh 1 >nightly.mem.${simpleDate}.log;sh check_result.sh nightly.mem.${simpleDate}.log Inceptor-SQL-MEM/logs_mem/"

