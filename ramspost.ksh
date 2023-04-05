#!/bin/ksh

loop( ) {

GPREFIX="ensfisfy60"
nomeexp="avaliacao"


# Definindo variaveis de datas
yyyy=`echo ${START_DATE} |cut -c 1-4`
mm=`echo ${START_DATE} |cut -c 5-6` 
dd=`echo ${START_DATE} |cut -c 7-8`
hh=`echo ${START_DATE} |cut -c 9-10`
amd=`echo ${START_DATE} |cut -c 1-8`    #amd= ano mes dia
d=`echo ${START_DATE} |cut -c 8-8`

POSDIR=/stornext/home/ariane.frassoni/RAMSPOST_NOVO/Ramspost-5.1
#/scratchin/grupos/catt-brams/home/ariane.frassoni/Ramspost_50

set -A cls EN AS MC LO SC GR 
set -A apr precip precip precip precip precip

v=0

while [ $v -le 0 ]; do

  CLTYPE=${cls[$v]}
  echo ${CLTYPE}

DATAIN=ANL_${CLTYPE}

#DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/experimentos/ramspost/ANL_${CLTYPE}/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}
#DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/avaliacao/ciclo_diurno/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}
DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/novo_entranhamento/ANL_${CLTYPE}/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}
#DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/ciclo_diurno/ANL_${CLTYPE}/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}


echo $DATAOUT 


cat << EOF > ${POSDIR}/ramspost.inp
\$RP_INPUT
    FPREFIX = '${DATAIN}/${yyyy}${mm}${dd}/GD-${CLTYPE}-${GPREFIX}-*',
    NVP = 1,
    VP = 'precip',
         'rshort',
         'tempc2m',
         'dewptc',
         'ue_avg',
         've_avg',
         'slp',
         'precip',
         'cape',
         'cine',
         'totpcp',
         'theta_e',
         'rh',
         'geo',
         'upmf',
         'dnmf',
         'topcl',
         'sst',

!    GPREFIX    ='GD-${nomeexp}-e1-${apr}-${CLTYPE}-${GPREFIX}',
    GPREFIX    ='GD-${apr}-${CLTYPE}-${GPREFIX}',

    ANL2GRA ='ONE',

    PROJ ='YES',
    MEAN_TYPE ='VMP', 
!    MEAN_TYPE ='BAV', 
    LATI =  -90., -90.,  -90.,
    LATF =   90.,  90.,   90., 
    LONI = -180., -180., -180.,
    LONF =  180.,  180.,  180.,
    
    ZLEVMAX = 41,20,30,
    
    IPRESSLEV = 0,
    INPLEVS = 12,
    IPLEVS = 2, 4, 6,7,8, 10, 12,14, 16,19,21, 23,
    ASCII_DATA ='NO',
    SITE_LAT =-10.76,
    SITE_LON =-62.36,

 \$end
EOF

cd ${POSDIR}
./ramspost_50

#echo mv ${POSDIR}/GD-${nomeexp}-e1-${apr}-${CLTYPE}-${GPREFIX}* ${DATAOUT}
#mv ${POSDIR}/GD-${nomeexp}-e1-${apr}-${CLTYPE}-${GPREFIX}* ${DATAOUT}

echo mv ${POSDIR}/GD-${apr}-${CLTYPE}-${GPREFIX}* ${DATAOUT}
mv ${POSDIR}/GD-${apr}-${CLTYPE}-${GPREFIX}* ${DATAOUT}


 v=$((v+1))
done

# Funcao "data"

}

START_DATE=20080101
END_DATE=20080123

while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   loop ${START_DATE}

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done




