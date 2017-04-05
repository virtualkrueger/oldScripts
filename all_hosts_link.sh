#!/usr/bin/bash -x

DATE=`date +%Y%m%d`

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

for i in ${hosts[*]}
do
        echo "****************************************" >> /tmp/interfaces
        echo "*$i Interface Duplex Information*" >> /tmp/interfaces
        echo "****************************************" >> /tmp/interfaces
        HOSTTYPE=`ssh $i "uname -i" | awk -F- '{ print $3 }'`
        case "$HOSTTYPE" in
                V240 )  for int in ${int240[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" >> /tmp/interfaces
                                done;;
                280R )  for int in ${int280[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" >> /tmp/interfaces
                                done;;
                V440 )  for int in ${int440[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" >> /tmp/interfaces
                                done;;
                480R )  for int in ${int480[*]}
                                do
                                        ssh $i "sudo /usr/local/bin/linkcheck.ksh $int" >> /tmp/interfaces
                                done;;
        esac
done

