for i in msse04_bcv001_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv002_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv003_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv004_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv005_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv006_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv007_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv008_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv009_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv010_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv011_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spa sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done
for i in msse04_bcv012_08hr
 do
        x=0
        while (( $x < 100 ))
         do
         x=`/opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -complete -name $i | grep Complete | awk '{ print $3 }'`
         echo "`date +%H%H%S` : $i is $x percent complete" >> /opt/emc/sancopy/logs/sancopy.log
         sleep 60
        done

        /opt/Navisphere/bin/navicli -h dc2-cx700b-spb sancopy -info -name $i -all >> /opt/emc/sancopy/logs/sancopy.log 2>&1
done

