#!/usr/bin/python
import sys

def diff(list1, list2, deviation, USE_HIVE_SERVER_2):
  flag = 1
  for i in range(len(list1)):
    for j in range(len(list2)):
      if isSame(list1[i], list2[j], deviation, USE_HIVE_SERVER_2) == 0:
        flag = 0
        break
    if flag == 0:
      #print "some line is right!"
      del list2[j]
      flag = 1
  if len(list2) == 0:
    return 0
  else:
    return 1

def isSame(line1, line2, deviation, USE_HIVE_SERVER_2):
  if USE_HIVE_SERVER_2 == 1:
    columns1 = line1.strip().split('|')
    del columns1[0]
    del columns1[len(columns1) - 1]
  else:
    columns1 = line1.strip().split('\t')
  columns2 = line2.strip().split('\t')
  exit_state = 0
  if len(columns1) != len(columns2):  # Two lines are different
    exit_state = 1
    return exit_state
  else:
    column_num = len(columns1)
    if column_num == 0:
      return 0  # Two lines are both blank, consider them as same
    else:
      for idx in range(column_num):
        try:
          column_content1 = float(columns1[idx].strip())
          column_content2 = float(columns2[idx].strip())
        except:
          column_content1 = columns1[idx].strip()
          if column_content1.lower() == "true" or column_content1.lower() == "false":
            column_content1 = column_content1.lower()
          column_content2 = columns2[idx].strip()
          if column_content2.lower() == "true" or column_content2.lower() == "false":
            column_content2 = column_content2.lower()
        if isinstance(column_content1, float) and isinstance(column_content2, float):
          different = column_content1 - column_content2

          if different < 0:
            different = 0 - different
          tmp = different - deviation
          #print(tmp)
          if tmp > 1e-3:
            # print "1e-3!"
            exit_state = 1
        else:
          cmp_result = cmp(column_content1,column_content2)
          if cmp_result != 0:
            exit_state = 1
  return exit_state

def readFile(file, USE_HIVE_SERVER_2):
  list = []
  lines = open(file, 'r')
  num = 1
  for line in lines:
    if USE_HIVE_SERVER_2 == 1:
      if num == 2 or line.find("+----") == 0:
        num += 1
        continue
      elif len(line.strip().split('|')) == 1 and line.strip().split('|')[0] == "":
        num += 1
        continue
      else:
        list.append(line)
        num += 1
    else:
      if line.find("Time taken") == 0 or line.find("SLF4J") == 0:
        continue
      elif len(line.strip().split('\t')) == 1 and line.strip().split('\t')[0] == "":
        continue
      else:
        list.append(line)
  return list

if __name__ == "__main__":
  file1 = sys.argv[1]
  file2 = sys.argv[2]
  tmp_deviation = sys.argv[3]
  TMP_USE_HIVE_SERVER_2 = sys.argv[4] 
  deviation = float(tmp_deviation)
  USE_HIVE_SERVER_2 = int(TMP_USE_HIVE_SERVER_2)

  list1 = readFile(file1, USE_HIVE_SERVER_2)
  list2 = readFile(file2, 0)
  #print(len(list1))
  #print(len(list2))

  if len(list1) != len(list2):
    print "Result is different from standard result --- different line numbers !"
    exit(1)

  if diff(list1, list2, deviation, USE_HIVE_SERVER_2) == 0:
    print "Result is the same to the standard result!"
    exit(0)
  else:
    print "..."
    exit(1)
