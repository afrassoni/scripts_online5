#!/bin/ksh


# este script copia os dados processados e interpolados na grade do
# arquivo merge e move os arquivos copiados para um diretorio separado
# por prazo de previsao

loop( ) {



# Definindo variaveis de datas
yyyy=`echo ${START_DATE} |cut -c 1-4`
mm=`echo ${START_DATE} |cut -c 5-6` 
mmm=`echo ${START_DATE} |cut -c 5-6`
dd=`echo ${START_DATE} |cut -c 7-8`
hh=`echo ${START_DATE} |cut -c 9-10`
amd=`echo ${START_DATE} |cut -c 1-8`    #amd= ano mes dia
d=`echo ${START_DATE} |cut -c 8-8`

yyyymmOBS=`date +%Y%m -d "${amd} 0 days"`
yyyymmddOBS=`date +%Y%m%d -d "${amd} 0 days"`

yyyymmddM24h=`date +%Y%m%d -d "${amd} 5 days"`
yyyyM24h=`echo ${yyyymmddM24h} |cut -c 1-4`
mmM24h=`echo ${yyyymmddM24h} |cut -c 5-6` 
ddM24h=`echo ${yyyymmddM24h} |cut -c 7-8`
#admM24h=`date +%d%b%Y -d "${amd} 1 days"`

echo ${START_DATE}
echo $yyyymmddM24h

nome="ensfisfy60"
prazo="120h"

set -A cls EN 
set -A apr precip precip precip precip precip precip

v=0

while [ $v -le 0 ]; do

  CLTYPE=${cls[$v]}
  echo ${CLTYPE}

  DATAIN=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/merge/ANL_${CLTYPE}/${yyyy}${mm}${dd}
  DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/merge/ANL_${CLTYPE}/${prazo}; mkdir -p ${DATAOUT}

  FILEINC=GD-${apr}-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl
  FILEINB=GD-${apr}-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.bin

  FILEOUC=GD-${apr}-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl
  FILEOUB=GD-${apr}-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.bin

  cp -pvfr ${DATAIN}/${FILEINC} ${DATAOUT}/${FILEOUC}
  cp -pvfr ${DATAIN}/${FILEINB} ${DATAOUT}/${FILEOUB}

echo   "cp -pvfr ${DATAIN}/${FILEINC} ${DATAOUT}/${FILEOUC}"
echo   "cp -pvfr ${DATAIN}/${FILEINB} ${DATAOUT}/${FILEOUB}"


# utilizado para renomear o arquivo G3D para o fechamento AS
#    cp -pvfr ${DATAOUT}/${FILEOUC} ${DATAOUT}/${FILEOUC}.tmp
#    sed -i "s,G3D,GD,g" ${DATAOUT}/${FILEOUC}.tmp
#    cp -pvfr ${DATAOUT}/${FILEOUC}.tmp ${DATAOUT}/${FILEOUC}
#    rm ${DATAOUT}/${FILEOUC}.tmp


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

