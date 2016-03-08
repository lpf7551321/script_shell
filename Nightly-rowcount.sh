#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/Nightly-rowCount
pwd

for file in `ls testrowcount/inceptortable`
do
  echo "$file"
  juLog -name=$file   "sh rowcountTest.sh $file"
done

for file in `ls testrowcount/hbasetable_shell`
do
  echo "$file"
  juLog -name=$file   "sh rowcountTest01.sh $file"
done
transwarp -t -h localhost -f  testrowcount/shell_restore
for file in `ls testrowcount/hbasetable_plsql`
do
  echo "$file"
  juLog -name=$file   "sh rowcountTest02.sh $file"
done

