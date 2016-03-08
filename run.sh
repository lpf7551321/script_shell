#!/bin/sh
basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#get the basedir
basedir=`pwd`
echo $basedir

#### Clean old reports
juLogClean

#generate data and sql
java -cp RandomGenerator.jar NightlyTest.BloomFilterTest.BloomTest
#java -cp RandomGenerator.jar NightlyTest.BloomFilterTest.BloomFilterTestNightly

#change data set
#sh changedataset.sh

#preddl
echo "transwarp -t -h localhost -f $basedir/ddl/preddl.sql"
transwarp -t -h localhost -f $basedir/ddl/preddl.sql

cd $basedir/ddl/bloomddl
for ddlFile in `ls *.sql`
do
#run one of muti ddl
echo "transwarp -t -h localhost -f $basedir/ddl/bloomddl/$ddlFile"
transwarp -t -h localhost -f $basedir/ddl/bloomddl/$ddlFile

#run sql and get results
cd $basedir
java -cp RandomGenerator.jar NightlyTest.BloomFilterTest.BloomFilterTestNightly

#verify the result
echo "juLog  -name=bloomfilter-$ddlFile "python $basedir/diff.py $basedir/result/result $basedir/reference/reference 0 0""
juLog  -name=bloomfilter-$ddlFile "python $basedir/diff.py $basedir/result/result $basedir/reference/reference 0 0"

done

