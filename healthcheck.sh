#!/usr/bin/bash -x
# This script will accomplish the following (perhaps not in a pretty fashion, 
# but accomplished nonetheless): 
# Check host disk space
# Check /var/adm/messages
# Check the BCV backup script on applicable hosts
# Check root disk mirroring status
# Check cluster status on applicable hosts
# Check error counts on Ethernet Interfaces

#####
# I don't yet know how many global variables we may get for this script
# but I guess we gotta start somewhere.
#####

DATE=`date +%Y%m%d`

######
# Here we set up the array ${hosts[*]} to store the hostnames in the environment
# I'm sure there are much more elegant ways to do this, but I need something
# now.  So I get the dirty but functional way for now.  :-(
#####

hosts=(dir01 dir02 dirc01 dirc02 dirc03 dirc04 mss01 mss02 mss03 mss04 mss05 mss06 mss07 mss08 mssd01a mssd02a mssd03a mssd04a mssd05a msse01a msse02a msse03a msse04a msse05a fep01 fep02 fep03 fep04 fep05 fep06 fep06 fep07 fep08 fep09 fep10 fep13 mtai01 mtai02 mtai03 mtai04 mtai05 mtao01 mtao02 mtao03 mtao04 mtao05 que01 que02 que03 que04 media01)

bcvhosts=(dir01 dir02 mss01 mss02 mss03 mss04 mss05 mss06 mss07 mss08 mssd01a mssd02a mssd03a mssd04a mssd05a msse01a msse02a msse03a msse04a msse05a)

int240[0]=bge0
int240[1]=bge1
int240[2]=bge2
int240[3]=bge3

int280[0]=eri0
int280[1]=qfe0
int280[2]=qfe1
int280[3]=qfe2
int280[4]=qfe3

int440[0]=ce0
int440[1]=ce1
int440[2]=qfe0
int440[3]=qfe1
int440[4]=qfe2
int440[5]=qfe3
int440[5]=qfe4
int440[5]=qfe5
int440[5]=qfe6
int440[5]=qfe7

int480[0]=ce0
int480[1]=ce1
int480[2]=qfe0
int480[3]=qfe1
int480[4]=qfe2
int480[5]=qfe3
int480[6]=qfe4
int480[7]=qfe5
int480[8]=qfe6
int480[9]=qfe7

#####
# Now we set up the temp directory
#####

if [ -d /tmp/daily.$DATE ]
then
	echo "This script has been run today.  Exiting" 
else
	mkdir /tmp/daily.$DATE
fi

for i in ${hosts[*]}
do
	touch /tmp/daily.$DATE/$i
done

#####
# Let's get to collecting some data, shall we?
# This will log into each box and run dfmg.ksh for a nice formatted df display
# This section takes approximately 2m12s to complete.  This time will grow with
# each additional host.
#####

for i in ${hosts[*]}
do

	echo "****************************************" >> /tmp/daily.$DATE/$i
	echo "**********Disk Utilization**************" >> /tmp/daily.$DATE/$i
	echo "****************************************" >> /tmp/daily.$DATE/$i
	ssh $i "/usr/local/bin/maxdf.ksh" >> /tmp/daily.$DATE/$i
	echo "" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "**********/var/adm/messages*************" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        ssh $i "tail -100 /var/adm/messages" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "************Volume Status***************" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        ssh $i " if [ -f /usr/sbin/metastat ]; then /usr/sbin/metastat; else sudo /usr/sbin/vxdisk list | grep -v -; fi" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "***Userland Interface Information*******" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        ssh $i "sudo /sbin/ifconfig -a" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "****Interface Duplex Information********" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        HOSTTYPE=`ssh $i "uname -i" | awk -F- '{ print $3 }'`
        case "$HOSTTYPE" in
                V240 )  for int in ${int240[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
                                done;;
                280R )  for int in ${int280[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
                                done;;
                V440 )  for int in ${int440[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
                                done;;
                480R )  for int in ${int480[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
                                done;;
        esac
done
 
for i in ${bcvhosts[*]}
do
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "**********BCV Backup Status*************" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        BCVLOG=`ssh $i "ls -ltr /opt/emc/backup/log | tail -2 | grep -v cronout" | awk '{print $9}'`
	ssh $i "tail /opt/emc/backup/log/$BCVLOG" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
done

touch /tmp/daily.$DATE/mss_cluster_A
ssh mss04 "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/mss_cluster_A

touch /tmp/daily.$DATE/mss_cluster_B
ssh mss08 "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/mss_cluster_B

touch /tmp/daily.$DATE/mss_cluster_D
ssh mssd05a "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/mss_cluster_D

touch /tmp/daily.$DATE/mss_cluster_E
ssh msse05a "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/mss_cluster_E

touch /tmp/daily.$DATE/dir_cluster
ssh dir02 "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/dir_cluster

for i in `ls /tmp/daily.$DATE`
do
	cat /tmp/daily.$DATE/$i | mailx -s "Health Check $i $DATE" -c "rtoner@chartercom.com churt@chartercom.com tbegley@chartercom.com" jkrueger@chartercom.com
done	
