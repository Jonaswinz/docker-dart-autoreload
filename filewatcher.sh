#!/bin/bash

#Important: Use Unix Line Separator (\n) instead of the Windows one (\n) [Settings -> Code Style -> Line separator].

startscript=bin/main.dart
watchdir=/app/bin/*

echo "starting..."

pub get

declare -i printed=0

nohup /usr/bin/dart $startscript &>log.txt & echo $! > save_pid.txt & echo $! > log.txt

readLength(){
    sum=0
    for file in $watchdir*; do
      if [[ -f "$file" ]]
      then
        sum+=$(md5sum "$file")
      fi
    done
	echo $sum
}

while :
  do
    if (( printed < $(stat --printf="%s" log.txt))); then
      # shellcheck disable=SC2155
      declare -i temp=$(stat --printf="%s" log.txt)
      ((temp=temp-printed))
      tail -c "$temp" log.txt
      printed=$(stat --printf="%s" log.txt)
    fi

    sum1=$(readLength)
    sleep 2
	sum2=$(readLength)

    if [ "$sum1" != "$sum2" ]; then
      echo "Reloading Dart"
      # shellcheck disable=SC2046
      # shellcheck disable=SC2006
      kill -9 `cat save_pid.txt`
      rm save_pid.txt
      rm log.txt
      nohup /usr/bin/dart $startscript &>log.txt & echo $! > save_pid.txt
      declare -i printed=0
    fi

  done

sleep 1000