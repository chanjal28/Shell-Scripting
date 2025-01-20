#!bin/bash
# This Script will monitor the disk space and share mail to the user on utilisation.

ALERT=90 #Sets the disk usage threshold to 90%.
ADMIN="chanjalchandran2801@gmail.com"

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5 " "$1 }' | while read -r output;
do
  echo "$output" #echo "$output": Prints the line to the screen for debugging or logging
  usep=$( echo "$output" | awk '{print $1}' | cut -d '%' -f1 )
  partition=$( echo "$output" | awk '{print $2}')
  if [ "$usep" -ge "$ALERT" ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
    mail -s "ALERT: Disk almost out of space $usep%" "$ADMIN"
  fi
done

