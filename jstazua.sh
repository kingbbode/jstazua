#!/bin/bash
# Jstack Parser
# https://github.com/kingbbode/jstazua
#
# Implemented by Kingbbode (kingbbode@gmail.com)
#
# If you have a problem, please report it in the github issue.
# https://github.com/kingbbode/gitzua/jstazua
#
# JSTACK GAZUA~~!!

print_state()  {
  local status=$1
  echo "$status COUNT : $(cat $temp_file | grep ' $status' | wc -l)"
  echo "************** stack stat **************"
  echo "$(cat $temp_file | grep -A 1 ' $status' | grep -Ev '^$| $status|--' | awk '{print $(NF)}' | sort | uniq -c)"
  echo ""
}

if [[ -z $1 ]]; then
  echo "useage) check.sh filename"
  exit 1
fi

file=$1
if [[ -f "$file" ]]; then
  echo "$file found."
else
  echo "$file not found."
  exit 1
fi
temp_file=tmp$(date +%m%d%H%M%S).log
cat $file | grep -Ev 'at java|Native Method|at org.springframework|at sun.reflect|at org.apache|at com.sun|- parking
to wait for' > $temp_file
if [[ -f "$temp_file" ]]; then
  echo "$file found."
else
  echo "$temp_file not found."
  exit 1
fi
echo "****************************************************"
echo "**************** JSTACK GAZUA !! *******************"
echo "****************************************************"

echo "RUNABLE COUNT : $(cat $temp_file | grep ' RUNNABLE' | wc -l)"
echo "************** stack stat **************"
echo "$(cat $temp_file | grep -A 1 ' RUNNABLE' | grep -Ev '^$| RUNNABLE|--' | awk '{print $(NF)}' | sort | uniq -c)"
echo ""

echo "BLOCK COUNT : $(cat $temp_file | grep ' BLOCK' | wc -l)"
echo "************** stack stat **************"
echo "$(cat $temp_file | grep -A 1 ' BLOCK' | grep -Ev '^$| BLOCK|--' | awk '{print $(NF)}' | sort | uniq -c)"
echo ""

echo "WAITING COUNT : $(cat $temp_file | grep ' WAITING' | wc -l)"
echo "************** stack stat **************"
echo "$(cat $temp_file | grep -A 1 ' WAITING' | grep -Ev '^$| WAITING|--' | awk '{print $(NF)}' | sort | uniq -c)"
echo ""

echo "TIMED_WAITING COUNT : $(cat $temp_file | grep 'TIMED_WAITING' | wc -l)"
echo "************** stack stat **************"
echo "$(cat $temp_file | grep -A 1 'TIMED_WAITING' | grep -Ev '^$|TIMED_WAITING|--' | awk '{print $(NF)}' | sort | uniq -c)"
echo ""

echo "*********Lock Points**********"
echo "$(cat $temp_file | grep locked | awk '{print $5}' | sort | uniq -c)"

rm -rf $temp_file
