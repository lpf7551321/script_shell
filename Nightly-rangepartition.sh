#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/range_partition
pwd
tmpname=''
flag=1
for dir in `ls`
do
 echo "---------------------------------------------------------------------------->$dir"
  if [ "$dir" = "run.sh" ];then
    echo ""
  else
  for file in `ls $dir`
  do
    if [ "$file" = "create_table_orc.sql" ]; then
      juLog -name=$file   "sh run.sh $dir/$file"
      if [ $flag -eq 2 ];then
         juLog -name=$tmpname   "sh run.sh $dir/$tmpname"
      else
        flag=2 
      fi
    fi
    if [ "$file" = "query.sql"  ]; then
      juLog -name=$file   "sh run.sh $dir/$file"
    fi
    if [ "$file" = "create_table_mem.sql" ]; then
      if [ $flag -eq 1 ];then
        flag=2
        tmpname=$file
      else
         juLog -name=$file   "sh run.sh $file"
      fi
    fi
    if [ "$file" = "create_table_txt.sql" ]; then
      juLog -name=$file   "sh run.sh $dir/$file"
      if [ $flag -eq 2 ];then
         juLog -name=$tmpname   "sh run.sh $dir/$tmpname"
      else
        flag=2 
      fi
    fi
  done
  flag=1
  tmpname=''
  echo "=========================================="
  fi
done


