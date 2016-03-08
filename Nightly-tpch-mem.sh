#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd  $basedir/tpch_2_17_0

for file  in `ls transwarp_queries`
do
  echo "$file"
  sql_name=`echo $file | awk -F '.' '{print $1}'` 
  juLog  -name=tpc-h-$sql_name    "sh run.sh $sql_name tpch_mem"
done
  

