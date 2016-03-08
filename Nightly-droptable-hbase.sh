#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/drop_table_test/

juLog -name=test   "sh  run2.sh "


#for i in `seq 1 50`
#do
#  juLog -name=$i   "sh  run.sh "
#done

