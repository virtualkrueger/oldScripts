#!/usr/bin/bash

BCVLOG="/opt/emc/backup/log/`ls -ltr /opt/emc/backup/log | grep -v cronout | tail -1 | awk '{print $9}'`"
someone_who_cares=dlcorpdssg@chartercom.com
someone_who_really_cares=imsysmon-fatal@opennms01.charter.net
BCVSTATUS=`tail -1 $BCVLOG | awk '{print $11}'`
mnt=`mount -p | awk '( $3 ~ /imail$/ ) {print $3}'`
mss=`dirname $mnt | awk -F/ '{print $2}'`


bcvstatus()
{
case "$BCVSTATUS" in
        0 )     echo "BCV Backup successful" | mailx -s "`hostname` BCV Successful `date`" $someone_who_cares ;;
        * )     echo "BCV Backup Failed.  Check `hostname`:$BCVLOG for details" | mailx -s "`hostname` BCV Failed `date`" $someone_who_really_cares ;;
esac
}


case "$mss" in
	mssd01 )	bcvstatus ;;
	mssd02 )	bcvstatus ;;
	mssd03 )	bcvstatus ;;
	mssd04 )	bcvstatus ;;
	msse01 )	bcvstatus ;;
	msse02 )	bcvstatus ;;
	msse03 )	bcvstatus ;;
	msse04 )	bcvstatus ;;
	mssf01 )	bcvstatus ;;
	mssf02 )	bcvstatus ;;
	mssf03 )	bcvstatus ;;
	mssc01 )	bcvstatus ;;
	mssc02 )	bcvstatus ;;
	mssc03 )	bcvstatus ;;
	mssc04 )	bcvstatus ;;
	* )	echo "MSS not failed over to this host.  No BCV operations will run." | mailx -s "`hostname` BCV not applicable for this host `date`" $someone_who_cares ;;

esac
