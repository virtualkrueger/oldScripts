#!/bin/sh

for i in `grep scsi /var/adm/messages | grep lpfc | awk '{print $11}' | sed s/\(\// | sed s/\)\// | sed s/\:\// | sort | uniq`
do
/usr/local/bin/sd2ctd.sh $i
done

