#!/bin/sh
df -H /dev/sda2 | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 90 ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
    ./telegram.sh "Alerta de Espacio en Disco $usep%" "`df -H /dev/sda2` | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }'"
  fi
done
