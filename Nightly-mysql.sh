#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd  $basedir/mysql-test
sh upload_data.sh

for file  in `ls cases`
do
  echo "$file" 
  juLog  -name=$file    "sh run_test.sh cases/$file"
done
  

