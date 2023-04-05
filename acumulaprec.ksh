#!/bin/ksh

cat << EOF > acumulaprec.gs
'reinit'
'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601.ctl'
'define soma=sum(prec,time=02jan2006,time=11jan2006)'
'set gxout fwrite'
'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601_02.bin'
'set x 1 201'
'set y 1 255'
'd soma'
'disable fwrite'
'quit'
EOF

cat << EOF > /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601_02.ctl
dset ^prec_200601_02.bin
undef -999.0
title Precipitacao acumulada em 10 dias
xdef   201 linear     -82.6250    0.2500
ydef   255 linear     -49.8750    0.2500
zdef    1 levels    1.
tdef   1 linear 12:00Z02JAN2006      24hr
vars   1
prec  0 99  precipitacao acumulada 240h
endvars
EOF


exit


#loop(){

ANL=${1}
FCT=${2}

nome="ensfis"
nome2="precip"
obs="merge"


case ${obs} in
trmm) arqobs="3B42V6.${ANL:0:6}.ctl"
      var="r"
      xx="198"
      yy="249"
      xi="-83.125"
      yi="-49.875"
;;
merge) arqobs="prec_${ANL:0:6}.ctl"
       var="prec"
       xx="201"
       yy="255"
       xi="-82.6250"
       yi="-49.8750"
;;
esac

v=0

while [ $v -le 5 ]; do

  CLTYPE=${cls[$v]}
  echo ${CLTYPE}

    DIROBS=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/${obs}/${ANL:0:6}
    DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/${obs}/


cat << EOF > lterp.gs
'reinit'
'open ${DIROBS}/${arqobs}'
'define soma=sum(prec,time=02jan2006,time=11jan2006)'

'set gxout fwrite'
'set fwrite ${DATAOUT}/GD-${nome2}-${CLTYPE}-${nome}-A-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.bin'
'd lterp(${apr[$v]}.2(t=1),${var}.1)'
'disable fwrite'
'quit'
EOF


echo "open ${DIRMODEL}/GD-${nome2}-${CLTYPE}-${nome}-A-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.ctl"

opengrads -lbc "run lterp.gs"

#-----------------------------------------------------------------------------------------------------------------
ctldate=`date "+%HZ%d%h%Y" --date="${FCT:0:4}-${FCT:4:2}-${FCT:6:2} ${FCT:8:2}:00:00" `
cat << EOT > ${DATAOUT}/GD-${nome2}-${CLTYPE}-${nome}-A-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.ctl 
dset ^GD-${nome2}-${CLTYPE}-${nome}-A-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.bin
undef -9.99e33
title RAMS 4.2 Output
xdef   ${xx} linear  ${xi}  0.2500
ydef   ${yy} linear  ${yi}  0.2500
zdef    1 levels    1.
tdef   1 linear ${ctldate}  1hr
vars   1
${apr[$v]}   0 99 - RAMS : acccum precip from ${cls[$v]} closure [mm]
endvars
EOT
#-----------------------------------------------------------------------------------------------------------------
     
 v=$((v+1))
done


# Funcao "data"

}


START_DATE=2006010112
END_DATE=2006013112
INCR=24

while [ ${START_DATE} -le ${END_DATE} ];do

  Y=${START_DATE:0:4}
  M=${START_DATE:4:2}
  D=${START_DATE:6:2}
  H=${START_DATE:8:2}
  echo "${START_DATE} :: ${Y}/${M}/${D} : ${H} horas"

  PSTART_DATE=${START_DATE}
  PEND_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00 240 hours"`
  PINCR=24
  while [ ${PSTART_DATE} -le ${PEND_DATE} ]; do

     PY=${PSTART_DATE:0:4}
     PM=${PSTART_DATE:4:2}
     PD=${PSTART_DATE:6:2}
     PH=${PSTART_DATE:8:2}
#     echo " -------> ${PY}/${PM}/${PD} : ${PH} horas"

#loop ${START_DATE} ${PSTART_DATE}




     PSTART_DATE=`date "+%Y%m%d%H" --date="${PY}-${PM}-${PD} ${PH}:00:00 ${PINCR} hours"`
  done


  START_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00  ${INCR} hours"`
done

