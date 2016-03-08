#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/partition_test_baisheng/
# generate ref 
echo "generate ref now..."
rm -fr ./sql/reference/*.ref
for sql in `ls ./sql/reference/*.sql`; do
  echo "generate reference: $sql"
  juLog -name=$sql   "sh  sql/runref.sh $sql"
done

##execute sql 
echo "execute sql now..."
pwd
simpleDate=`date +%F`
mkdir -p sql/result/$simpleDate
result_dir=$simpleDate
set -x
if [ -n "$result_dir" ];then
  rm -rf sql/result/$result_dir/*
fi
set +x

for file in `ls ./sql/cases`
do
  echo "execute file:$file"
  juLog -name=$file   "sh  sql/runcase.sh $file $result_dir"
done

