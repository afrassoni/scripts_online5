#!/bin/ksh

loop(){

ANL=${1}
FCT=${2}

echo $1
echo $2


nome="ensfis"
nome2="precip"
obs="merge"
exp=5


case ${obs} in
trmm) arqobs="3B42V6.${ANL:0:6}.ctl"
      var="r"
      xx="198"
      yy="249"
      xi="-83.125"
      yi="-49.875"
;;
merge) arqobs="prec_${ANL:0:8}.ctl"
       var="prec"
       xx="201"
       yy="255"
       xi="-82.6250"
       yi="-49.8750"
;;
esac

DIROBS=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/${obs}/${ANL:0:6}
DIRMODEL=/stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h
DIRFY=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/comparacao

set -A cls AS GR MC LO SC EN FY
set -A apr precip precip precip precip precip prec

v=0

while [ $v -le 6 ]; do
  CLTYPE=${cls[$v]}

  arqmodel="GD-${nome2}-${CLTYPE}-${nome}-A-${ANL:0:4}-${ANL:4:2}-${ANL:6:2}-${ANL:8:2}0000-g1.ctl"

  case ${cls[$v]} in
       FY) arqmodel="NewPrec_${exp}.ctl"
           DIRMODEL=${DIRFY}
           apr="prec"
  ;;
  esac

cat << EOF >/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/scatter.gs
'reinit'
'open ${DIROBS}/${arqobs}'
'open ${DIRMODEL}/${arqmodel}'
'set display color white'
'c'
'set t 1'
'set gxout scatter'
'set vrange 0 280'
'set vrange2 0 280'
'd prec.1;${apr}.2'
'draw title Scatter Plot ${D}/${M}/${Y}'
'draw xlab Observacao'
'draw ylab Previsao de 24h'
'run scatter_fit_stats.gs prec.1 ${apr}.2'
'save scatter_${CLTYPE}-${ANL:0:4}${ANL:4:2}${ANL:6:2}${ANL:8:2}'

'!convert -rotate 90 -density 100 -flatten scatter_${CLTYPE}-${ANL:0:4}${ANL:4:2}${ANL:6:2}${ANL:8:2}.eps scatter_${CLTYPE}-${ANL:0:4}${ANL:4:2}${ANL:6:2}${ANL:8:2}.png'
'quit'
EOF

opengrads -lbc "run scatter.gs"


v=$((v+1))
done

rm *.eps

# Funcao "data"

}


START_DATE=2006010212
END_DATE=2006020212
INCR=24

while [ ${START_DATE} -le ${END_DATE} ];do

  Y=${START_DATE:0:4}
  M=${START_DATE:4:2}
  D=${START_DATE:6:2}
  H=${START_DATE:8:2}
  echo "${START_DATE} :: ${Y}/${M}/${D} : ${H} horas"

  PSTART_DATE=${START_DATE}
  PEND_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00 00 hours"`
  PINCR=24
  while [ ${PSTART_DATE} -le ${PEND_DATE} ]; do

     PY=${PSTART_DATE:0:4}
     PM=${PSTART_DATE:4:2}
     PD=${PSTART_DATE:6:2}
     PH=${PSTART_DATE:8:2}
#     echo " -------> ${PY}/${PM}/${PD} : ${PH} horas"

loop ${START_DATE} ${PSTART_DATE}

     PSTART_DATE=`date "+%Y%m%d%H" --date="${PY}-${PM}-${PD} ${PH}:00:00 ${PINCR} hours"`
  done


  START_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00  ${INCR} hours"`
done

