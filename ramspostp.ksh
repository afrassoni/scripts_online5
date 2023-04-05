#!/bin/ksh

# 
# Idem ao ramspost.ksh exceto que eh para gerar os arquivos somente com os 5 pesos
#

loop( ) {



# Definindo variaveis de datas
yyyy=`echo ${START_DATE} |cut -c 1-4`
mm=`echo ${START_DATE} |cut -c 5-6` 
dd=`echo ${START_DATE} |cut -c 7-8`
hh=`echo ${START_DATE} |cut -c 9-10`
amd=`echo ${START_DATE} |cut -c 1-8`    #amd= ano mes dia
d=`echo ${START_DATE} |cut -c 8-8`

GPREFIX="t_fft01"
ent="novo" # tipo de entranhamento
obs="merge"

POSDIR=/scratchin/grupos/catt-brams/home/ariane.frassoni/Ramspost_50
DATAIN=ANL/novo_entranhamento/aval_hora/ANL_EN
DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/G3D/ramspost/novo_entranhamento/aval_hora/${obs}/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}


cat << EOF > ${POSDIR}/ramspost.inp
\$RP_INPUT
    FPREFIX = '${DATAIN}/${yyyy}${mm}${dd}/G3D-EN-${GPREFIX}-A',
    NVP = 11,
    VP = 'weightGR',
         'weightW',
         'weightMC',
         'weightST',
         'weightAS',
         'APRGR',
         'APRW',
         'APRMC',
         'APRST',
         'APRAS',
         'acccon',


    GPREFIX    ='teste-G3D-EN-${GPREFIX}-w',
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


mv ${POSDIR}/teste-G3D-EN-${GPREFIX}-w* ${DATAOUT}

# Funcao "data"

}

START_DATE=20060101
END_DATE=20060101

while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   loop ${START_DATE}

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done




