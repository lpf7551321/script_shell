#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd  $basedir/transwarp_tpcds/

for conf in config_mem
do
  test_name=`echo $conf | awk -F '_' '{print $2}'`
  if [ $test_name == "mem" ]; then
    transwarp -t -h localhost -f ./create_mem_table.sql
  fi
  for i in {1..99}
  do
    sql_name=query${i}.sql
    if [ -e ./sql/fullset/${sql_name} ]; then
      echo $sql_name
      juLog  -name=tpc-ds-${test_name}-${sql_name}    "./tpcds-test-2g.pl -i ./conf/$conf -f $i -c"
    else
      echo "$sql_name is temporarily removed from tpc-ds test."
    fi
  done 
done
