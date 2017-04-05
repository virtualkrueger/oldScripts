for i in mssd01a mssd02a mssd03a mssd04a mssd05a msse01a msse02a msse03a msse04a msse05a mssf01a mssf02a mssf03a mssf04a dirm01a dirm02a
do echo $i 
ssh $i "sudo /etc/powermt display" | grep 230 
done
