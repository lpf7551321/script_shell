#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd  $basedir/minsheng-test/customers/minsheng



for file  in `ls qaSqls/localmode/`
do
  echo "$file"
  juLog  -name=minshengLocal-$file    "sh runLocal.sh $file"
done

for file2  in `ls qaSqls/clustermode/`
do
  echo "$file2"
  juLog  -name=minshengCLuster-${file2}    "sh runCluster.sh ${file2}"
done

for file3  in `ls qaSqls/testKeepNullColumn/`
do
  echo "$file3"
  juLog  -name=minshengKeepNUllColumn-${file3}  "sh KeepNullColumn.sh ${file3}"
done

