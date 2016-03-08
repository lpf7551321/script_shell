#!/bin/bash
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd $basedir/orc_transaction_crud
pwd

#for file in `ls sql`
#do
#  echo "$file"
#  juLog -name=$file   "sh run.sh $file"
#done


for file in `ls sql03 | grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql03"
done

for file in `ls sql04| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql04"
done

for file in `ls sql05| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql05"
done

for file in `ls sql06| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql06"
done

for file in `ls sql07| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql07"
done

for file in `ls sql08| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql08"
done

for file in `ls sql09| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql09"
done

for file in `ls sql12| grep "*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run02.sh $file sql12"
done

for file in `ls subqueryTarget| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run.sh $file subqueryTarget"
done

for file in `ls subqueryTarget_hyperbase| grep ".*.sql"`
do
  echo "$file"
  juLog -name=$file   "sh run.sh $file subqueryTarget_hyperbase"
done

cd /root/Nightly/orc_transaction_crud/sql12/TransactionOrcTest/bin
juLog -name=jdbc-orctransactionddl   "bash orctransactionddl.sh"




