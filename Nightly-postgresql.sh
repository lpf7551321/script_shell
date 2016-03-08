#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/postgreSql-test/
#COMMAND="transwarp -t -h localhost"
#$COMMAND -f drop_inceptor_table.sql
#hbase shell drop_hbase_table.hbase > /dev/null 2>&1

for file in `ls sql`
do
  echo "$file"
  juLog -name=$file   "sh  run.sh $file"
done

