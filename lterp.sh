#!/bin/sh -x

tstart=2006010212
tfinal=2006010312
incr="24 hour"
nome="ff2803"

 cls=("MC"  "LO"  "KF"  "GR"  "AS")
 apr=("aprmc"  "aprw"  "aprst"  "aprgr"  "apras")

v=0

while [ $v -le 4 ]; do

  CLTYPE=${cls[$v]}
  echo ${CLTYPE}

  while [ $tstart != $tfinal ];do
    year=${tstart:0:4}
    mon=${tstart:4:2}
    day=${tstart:6:2}
  
    DIRMODEL=/scratchin/grupos/catt-brams/home/ariane.frassoni/Ramspost_50/stor/${year}${mon}${day}
    DIROBS=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/obs/${year}${mon}
    DATAOUT=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/bin/20060101; mkdir -p

cat << EOF > lterp${CLTYPE}.gs
'reinit'
'open ${DIROBS}/prec_${year}${mon}${day}.ctl'
'open ${DIRMODEL}/G3D-EN-accpr-${CLTYPE}-A-${year}-${mon}-${day}-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ${DATAOUT}/G3D-EN-${nome}-accpr-${CLTYPE}-A-${year}-${mon}-${day}-120000-g1.bin'
'd lterp(${apr[$v]}.2(t=1),prec.1)'
'disable fwrite'
'quit'
EOF

#grads -lbc "run lterp.gs"
     
  tstart=`inctime ${tstart} +${incr} yyyymmddhh`
  done

 v=$((v+1))
done


