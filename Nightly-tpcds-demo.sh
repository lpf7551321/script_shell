#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd  $basedir/transwarp_tpcds/

for conf in config_range config_hbase config_hyperbase
do
  test_name=`echo $conf | awk -F '_' '{print $2}'`
  for i in {1..99}
  do
    sql_name=query${i}.sql
    if [ -e ./sql/fullset/${sql_name} ]; then
      echo $sql_name
      juLog  -name=tpc-ds-${test_name}-${sql_name}    "./genPerfFull.pl -i ./config/$conf -f $i -c"
    else
      echo "$sql_name is temporarily removed from tpc-ds test."
    fi
  done 
done
