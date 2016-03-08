#/bin/sh

basedir=`dirname $0`
#### Include the library
. $basedir/sh2ju.sh

#### Clean old reports
juLogClean

cd / 

juLog  -name="quota_check"    "sh /quota_check.sh"

