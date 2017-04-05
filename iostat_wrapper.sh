#!/bin/sh

DATE=`date`

echo "******* $DATE ******" >> /tmp/iostat.`hostname`.out
iostat -xCne >> /tmp/iostat.`hostname`.out
