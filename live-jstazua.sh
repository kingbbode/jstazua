#!/bin/bash

which jps &> /dev/null
if [ "$?" != "0" ]; then
    echo "jps is not installed..."
    exit 1
fi

which jstack &> /dev/null
if [ "$?" != "0" ]; then
    echo "jstack is not installed..."
    exit 1
fi

if [ -z $1  ] || [ -z $2 ]; then
  echo "usage> live-jstazua [application_name] [per_time] [folder_nmae_alias:optional]"
  echo "ex) list-jstazua jstack-service 1m --> per 1 minute"
  exit 1
fi

application=$1
per=$2
alias=$3
pid="$(jps | grep "$application" | cut -f1 -d' ')"
echo "$pid"
if [[ -z $pid ]]; then
  echo "could't find jps : $application"
  exit 1
fi

dir=alias_$(date +%m%d%H%M%S)

if [[ -f dir ]]; then
  echo "already exist folder($dir). please try again"
  exit 1
else
  echo "create directory $dir"
  mkdir $dir
fi

echo "****************************************************"
echo "****************** JSTACK GAZUA ********************"
echo "***************** RECODING  MODE *******************"
echo "****************************************************"

init=0

while : ; do
  init=$((init+1))
  jstack $pid > $dir/$init.log
  echo "create complated  jstack $init th."
  ./jstazua.sh $dir/$init.log
  echo "wait $per........"
  sleep $per
done
