#!/bin/ksh 

#module load grads

CLTYPE=EN
varm="precip"
obs="merge"
nome="GD-precip-${CLTYPE}-ensfisfy30-A"


lterp(){

ANL=${1}
FCT=${2}

echo $ANL
echo $FCT

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
       xx="196" #"201"
       yy="250" #"255"
       xi="-82.8000" #"-82.6250"
       yi="-50.2000" #"-49.8750"
;;
esac

DIRMODEL=/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/novo_entranhamento/ANL_${CLTYPE}
DIROBS=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs
DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/${obs}/ANL_${CLTYPE}/${ANL:0:8}; mkdir -p ${DATAOUT}

data=`echo ${ANL} |cut -c 1-8`
datactl=`date +%d%b%Y -d "${data} 0 days"`

cat << EOF > lterpdiff-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}.gs
'reinit'
'open ${DIROBS}/${obs}/${ANL:0:6}/prec_${ANL:0:6}.ctl'
'open ${DIRMODEL}/${ANL:0:8}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.ctl'
'set gxout fwrite'
'set fwrite ${DATAOUT}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.lterp'
'd lterp(${varm}.2(t=1),${var}.1)'
'disable fwrite'
'quit'
EOF

#module load grads
opengrads -lbc "run  lterpdiff-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}.gs"
rm lterpdiff-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}.gs


cat << EOF > ${DATAOUT}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.ctl
dset ^${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.lterp
undef -9.99e+08
xdef   ${xx} linear     ${xi}    0.2500
ydef   ${yy} linear     ${yi}    0.2500
zdef   1 levels    1.
tdef   1 linear 12:00Z${datactl}      1hr
vars 1
precip   0 0 daily precip  (mm/day)
ENDVARS
EOF


}

diff(){

ANL=${1}
FCT1=${2}
FCT2=${3}

cat << EOF > diff-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}.gs
'reinit'
'open ${DATAOUT}/${nome}-${FCT1:0:4}-${FCT1:4:2}-${FCT1:6:2}-${FCT1:8:2}0000-g1.ctl'
'open ${DATAOUT}/${nome}-${FCT2:0:4}-${FCT2:4:2}-${FCT2:6:2}-${FCT2:8:2}0000-g1.ctl'
'set gxout fwrite'
'set fwrite ${DATAOUT}/tmp.bin'
'd (${varm}.2(t=1)-${varm}.1(t=1))'
'disable fwrite'
'quit'
EOF


opengrads -lbc "run diff-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}.gs"
#rm diff-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}.gs


#rm ${DATAOUT}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.tmp.ctl
mv -vf ${DATAOUT}/tmp.bin ${DATAOUT}/${nome}-${FCT2:0:4}-${FCT2:4:2}-${FCT2:6:2}-${FCT2:8:2}0000-g1.bin

}



START_DATE=2010010112
END_DATE=2010010112
TMAX=96
INCR=24

while [ ${START_DATE} -le ${END_DATE} ];do

  Y=${START_DATE:0:4}
  M=${START_DATE:4:2}
  D=${START_DATE:6:2}
  H=${START_DATE:8:2}


  PSTART_DATE=${START_DATE}
  INCMAX=$((TMAX-INCR))
  PEND_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00  $INCMAX hours"`
  PINCR=24
  while [ ${PSTART_DATE} -le ${PEND_DATE} ]; do

     PY=${PSTART_DATE:0:4}
     PM=${PSTART_DATE:4:2}
     PD=${PSTART_DATE:6:2}
     PH=${PSTART_DATE:8:2}


     lterp ${START_DATE} ${PSTART_DATE}

     if [ ${START_DATE} -ne ${PSTART_DATE} ];then
        NEXT_DATE=`date "+%Y%m%d%H" --date="${PY}-${PM}-${PD} ${PH}:00:00 24 hours"`
     
        lterp ${START_DATE} ${NEXT_DATE}
        diff ${START_DATE} ${PSTART_DATE} ${NEXT_DATE}
       
     fi

     PSTART_DATE=`date "+%Y%m%d%H" --date="${PY}-${PM}-${PD} ${PH}:00:00 ${PINCR} hours"`
  done


  START_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00  ${INCR} hours"`
done


#cat << EOF > ${DATAOUT}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.ctl
#dset ^${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.bin
#undef -9.99e+08
#xdef   ${xx} linear     ${xi}    0.2500
#ydef   ${yy} linear     ${yi}    0.2500
#zdef   1 levels    1.
#tdef   1 linear 12:00Z${datactl}      1hr
#vars 1
#precip   0 0 daily precip  (mm/day)
#ENDVARS
#EOF

