PATH=$PATH:/opt/emc/backup/bin export PATH
host="`hostname`"
#mss="`ps -ef | grep imail | grep mss | head -1 | cut -d/ -f2`"
mnt=`mount -p | awk '( $3 ~ /imail$/ ) {print $3}'`
mss=`dirname $mnt | awk -F/ '{print $2}'`
logfile=/opt/emc/backup/log/${mss}.log.`date +%m%d%Y%H%M`
if [ "`ps -ef | grep imail | grep immgrserv | head -1 | cut -d/ -f2 | wc -l`" -ne 1 ]
then
    echo "$0:  FAILURE: Unable to determine running mss instance on $host" > $logfile
    exit 20
fi
echo "Backup Started at `date +%m%d%Y%H%M`" >> $logfile
INTERMAIL=/${mss}/imail/Mx6.0 export INTERMAIL
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/${mss}/imail/Mx6.0/lib export LD_LIBRARY_PATH
echo "Starting backup for instance: $mss on host: $host" >> $logfile

#  establish BCVs based on mss instance currently running on this host
backup.sh est none /opt/emc/backup/etc/${mss}_bcv_all >> $logfile

## use immsscall to place DB in backup mode
#echo "Turning on backup mode" >> $logfile
#/${mss}/imail/Mx6.0/bin/immsscall ${mss} backupmode on
#STAT=$?
#if [ ${STAT} != 0 ]; then
#    echo "FAILURE: Unable to set MSS backup mode ON - immsscall exit value ${STAT} - EXITING" >> $logfile
#    exit 1
#fi

#  split BCVs based on mss instance currently running on this host
backup.sh split none /opt/emc/backup/etc/${mss}_bcv_all >> $logfile

#echo "Turning off backup mode" >> $logfile
#/${mss}/imail/Mx6.0/bin/immsscall ${mss} backupmode off
#STAT=$?
#if [ ${STAT} = 0 ]; then
#         echo "Backup operation COMPLETED SUCCESSFULLY for $mss at `date +%m%d%Y%H%M`" >> $logfile
#        else
#         echo "FAILURE: Unable to set MSS backup mode  OFF - immsscall exit value ${STAT} - EXITING" >> $logfile
#         exit 1
#fi

/opt/emc/backup/bin/bcv_notifier.sh
