#!/bin/ksh

loop( ) {


ANL=${1}
FCT=${2}

nome="ensfis"
obs="merge"


set -A cls AS MC LO SC GR AS EN
set -A apr precip acccon acccon acccon acccon acccon acccon


v=0

while [ $v -le 1 ]; do

  CLTYPE=${cls[$v]}
  echo ${CLTYPE}

    DATAIN=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/teste/${obs}/ANL_${CLTYPE}/${ANL:0:8}

    DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/Firefly/novo_entranhamento/teste/${obs}/24h; mkdir -p ${DATAOUT}

cp ${DATAIN}/GD-${nome}-${CLTYPE}-ensfis-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1* ${DATAOUT}
echo "cp
${DATAIN}/GD-${nome}-${CLTYPE}-ensfis-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1*
${DATAOUT}"


 v=$((v+1))
done

# Funcao "data"

}

START_DATE=20060101
END_DATE=20060131

while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   loop ${START_DATE}

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done

