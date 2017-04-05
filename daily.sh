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

hosts[0]=dir01
hosts[1]=dir02
hosts[2]=dirc01
hosts[3]=dirc02
hosts[4]=dirc03
hosts[5]=mss01
hosts[6]=mss02
hosts[7]=mss03
hosts[8]=mss04
hosts[9]=mss05
hosts[10]=mss06
hosts[11]=mss07
hosts[12]=mss08
hosts[13]=que01
hosts[14]=que02
hosts[15]=que03
hosts[16]=que04
hosts[17]=fep01
hosts[18]=fep02
hosts[19]=fep03
hosts[20]=fep04
hosts[21]=fep05
hosts[22]=fep06
hosts[23]=fep07
hosts[24]=fep08
hosts[25]=fep09
hosts[26]=fep10
hosts[27]=fep11
hosts[28]=fep12
hosts[29]=fep13
hosts[30]=mtai01
hosts[31]=mtai02
hosts[32]=mtai03
hosts[33]=mtai04
hosts[34]=mtai05
hosts[35]=mtao01
hosts[36]=mtao02
hosts[37]=mtao03

bcvhosts[0]=dir01
bcvhosts[1]=dir02
bcvhosts[2]=mss01
bcvhosts[3]=mss02
bcvhosts[4]=mss03
bcvhosts[5]=mss04
bcvhosts[6]=mss05
bcvhosts[7]=mss06
bcvhosts[8]=mss07
bcvhosts[9]=mss08

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
done
 
#####
# This section will collect the last 100 lines of /var/adm/messages so we can
# look into potentially pressing issues that we wouldn't see elsewhere.
# This section takes approximately 0m56s to complete.  This time will grow with
# each additional host.
#####

for i in ${hosts[*]}
do
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "**********/var/adm/messages*************" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        ssh $i "tail -100 /var/adm/messages" >> /tmp/daily.$DATE/$i
	echo "" >> /tmp/daily.$DATE/$i
done

#####
# This section will collect status of the BCV backup script
# This section takes approximately 0m19s to complete.  This time will grow with
# each additional host.
#####

for i in ${bcvhosts[*]}
do
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "**********BCV Backup Status*************" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        BCVLOG=`ssh $i "ls -ltr /opt/emc/backup/log | tail -2 | grep -v cronout" | awk '{print $9}'`
	ssh $i "tail /opt/emc/backup/log/$BCVLOG" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
done

#####
# This section will grab the disk mirror status of the hosts.
# This section takes approximately 0m46s to complete.  This time will grow with
# each additional host.
#####

for i in ${hosts[*]}
do
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "************Volume Status***************" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
	ssh $i " if [ -f /usr/sbin/metastat ]; then /usr/sbin/metastat; else sudo /usr/sbin/vxdisk list | grep -v -; fi" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
done

#####
# This section will grab basic Ethernet interface information.
#####

for i in ${hosts[*]}
do
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "***Userland Interface Information*******" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
        ssh $i "sudo /sbin/ifconfig -a" >> /tmp/daily.$DATE/$i
        echo "" >> /tmp/daily.$DATE/$i
done

####
# This section will gather detailed Ethernet interface information.
#####

for i in ${hosts[*]}
do
        echo "****************************************" >> /tmp/daily.$DATE/$i
        echo "****Interface Duplex Information********" >> /tmp/daily.$DATE/$i
        echo "****************************************" >> /tmp/daily.$DATE/$i
	HOSTTYPE=`ssh $i "uname -i" | awk -F- '{ print $3 }'`
	case "$HOSTTYPE" in
		V240 )	for int in ${int240[*]}
				do
					ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
				done;;
		280R )	for int in ${int280[*]}
				do
					ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off>> /tmp/daily.$DATE/$i
				done;;	
		V440 )	for int in ${int440[*]}
				do
					ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
				done;;
		480R )	for int in ${int480[*]}
				do
					ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" | grep -v off >> /tmp/daily.$DATE/$i
				done;;
	esac
done

#####
# This section will verify cluster status for the VCS clusters
#####

touch /tmp/daily.$DATE/mss_cluster_A
ssh mss04 "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/mss_cluster_A

touch /tmp/daily.$DATE/mss_cluster_B
ssh mss08 "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/mss_cluster_B

touch /tmp/daily.$DATE/dir_cluster
ssh dir02 "sudo /opt/VRTSvcs/bin/hastatus -sum" >> /tmp/daily.$DATE/dir_cluster
