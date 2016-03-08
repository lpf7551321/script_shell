#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/ems
pwd

for file in `ls sql`
do
  echo "$file"
  juLog -name=$file   "sh ems.sh sql/$file"
done

