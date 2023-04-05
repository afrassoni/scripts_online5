#!/bin/sh -x


tstart=2006010112
tfinal=2006020112

incr="24 hour"

while [ $tstart != $tfinal ];do


  year=${tstart:0:4}
  mon=${tstart:4:2}
  day=${tstart:6:2}
  
  mkdir -p /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/${year}${mon}${day}

tstart=`inctime ${tstart} +${incr} yyyymmddhh`
done
