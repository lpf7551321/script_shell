#!bin/bash
hdfs dfs -rm /tmp/bloomfilter/data.txt
hdfs dfs -put data/data.txt /tmp/bloomfilter/data.txt
#transwarp -t -h localhost -f ddl.sql
