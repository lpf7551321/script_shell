#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

simpleDate=`date +%F | sed 's/-//g'`

cd  $basedir/anhui_mem
#juLog  -name=anhui-mem    "sh run-mem.sh"
sh run-mem.sh
echo ">>> Data tables established!"

#### run test cases in upper dir
basepath=`pwd`
echo ">>> basedir=$basedir"

for i in `ls sql/Inceptor-SQL-MEM/`
do
  echo  $basepath/sql/Inceptor-SQL-MEM/$i
#  transwarp -t -h localhost -f $basepath/sql/Inceptor-SQL-MEM/$i
  juLog -name=$i "transwarp -t -h localhost -f $basepath/sql/Inceptor-SQL-MEM/$i"
done

$cmd -f $basepath/sql/count_table/count_table.sql > count.log
sleep 50
diff count.log $basepath/RESULT
if [ $? != 0 ]
then
  echo "FAILED!"
  exit 1
else
  echo "PASS!"
  exit 0
fi

