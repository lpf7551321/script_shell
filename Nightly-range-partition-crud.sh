#!/bin/sh
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean
cd $basedir/crud
pwd

COMMAND="transwarp -t -h localhost"
$COMMAND -f external_table.sql

for dir in mc_date mc_int mc_string sc_date sc_int sc_string
do
  #create full/part range table
  $COMMAND -f $dir/${dir}_fullRange.sql
  $COMMAND -f $dir/${dir}_partRange.sql

  #start exec sql
  for file in query1 query2 query3 query4 query5
  do 
    juLog -name=$file   "sh run_sql.sh $dir $file"
  done
done

