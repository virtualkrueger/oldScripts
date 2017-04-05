
hagrp -freeze msse4-sg




sudo vxdctl enable




for i in 73 74 75 76 89 90 91 92 93 94 95 96; 
do 
	echo "c2t30d$i"; 
	puboff=`sudo vxdisk list c2t30d$i | grep public: | awk '{print $3}' | awk -F= '{print $2}'`; 
	echo "Public offset is $puboff"; 
	publen=`sudo vxdisk list c2t30d$i | grep public: | awk '{print $4}' | awk -F= '{print $2}'`; 
	echo "Public length is $publen";  
	privoff=`sudo vxdisk list c2t30d$i | grep private: | awk '{print $3}' | awk -F= '{print $2}'`; 
	echo "Private Offset is $privoff"; 
	privlen=`sudo vxdisk list c2t30d$i | grep private: | awk '{print $4}' | awk -F= '{print $2}'`; 
	echo "Private length is $privlen"; done




mfsctd=`sudo vxdisk list | grep mfs | awk '{print $1}' | awk -Fs '{print $1}'`



Public offset is 0
Public length is 226498560
Private Offset is 1
Private length is 3583

(jkrueger@msse04)()(12:14:26<>11/03/04)(S44)(H695)
(~)#> sudo vxdg init bcv_msse04_mfs_dg disk01=c2t40d85
(jkrueger@msse04)()(12:14:41<>11/03/04)(S45)(H696)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk02=c2t40d86
(jkrueger@msse04)()(12:15:09<>11/03/04)(S46)(H697)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk03=c2t40d87
(jkrueger@msse04)()(12:15:14<>11/03/04)(S47)(H698)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk04=c2t40d88
(jkrueger@msse04)()(12:15:18<>11/03/04)(S48)(H699)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk05=c2t40d89
(jkrueger@msse04)()(12:15:23<>11/03/04)(S49)(H700)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk06=c2t40d90
(jkrueger@msse04)()(12:15:28<>11/03/04)(S50)(H701)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk07=c2t40d91
(jkrueger@msse04)()(12:15:32<>11/03/04)(S51)(H702)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk08=c2t40d92
(jkrueger@msse04)()(12:15:38<>11/03/04)(S52)(H703)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk09=c2t40d93
(jkrueger@msse04)()(12:15:42<>11/03/04)(S53)(H704)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk10=c2t40d94
(jkrueger@msse04)()(12:15:47<>11/03/04)(S54)(H705)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk11=c2t40d95
(jkrueger@msse04)()(12:15:51<>11/03/04)(S55)(H706)
(~)#> sudo vxdg -g bcv_msse04_mfs_dg adddisk disk12=c2t40d96


hagrp -unfreeze msse4-sg
