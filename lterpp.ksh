#!/bin/ksh

# 
# Idem ao ramspost.ksh exceto que eh para gerar os arquivos somente com os 5 pesos
#


loop( ) {



# Definindo variaveis de datas
yyyy=`echo ${START_DATE} |cut -c 1-4`
mm=`echo ${START_DATE} |cut -c 5-6` 
mmm=`echo ${START_DATE} |cut -c 5-6`
dd=`echo ${START_DATE} |cut -c 7-8`
hh=`echo ${START_DATE} |cut -c 9-10`
amd=`echo ${START_DATE} |cut -c 1-8`    #amd= ano mes dia
d=`echo ${START_DATE} |cut -c 8-8`

yyyymmOBS=`date +%Y%m -d "${amd} 1 days"`
yyyymmddOBS=`date +%Y%m%d -d "${amd} 1 days"`

yyyymmddM24h=`date +%Y%m%d -d "${amd} 1 days"`
yyyyM24h=`echo ${yyyymmddM24h} |cut -c 1-4`
mmM24h=`echo ${yyyymmddM24h} |cut -c 5-6` 
ddM24h=`echo ${yyyymmddM24h} |cut -c 7-8`
admM24h=`date +%d%b%Y -d "${amd} 1 days"`


yyyymmddM48h=`date +%Y%m%d -d "${amd} 2 days"`
yyyyM48h=`echo ${yyyymmddM48h} |cut -c 1-4`
mmM48h=`echo ${yyyymmddM48h} |cut -c 5-6` 
ddM48h=`echo ${yyyymmddM48h} |cut -c 7-8`


nome="fft01"

    DIRMODEL=/stornext/grupos/catt-brams/ariane.frassoni/G3D/ramspost/novo_entranhamento/pesos/${yyyy}${mm}${dd}
    DIROBS=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/obs/${yyyymmOBS}
    DATAOUT=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/pesos/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}


cat << EOF > lterp.gs
'reinit'
'open ${DIROBS}/prec_${yyyymmddOBS}.ctl'
'open ${DIRMODEL}/G3D-EN-${nome}-w-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ${DATAOUT}/G3D-EN-${nome}-w-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.bin'
'd lterp(weightGR.2(t=1),prec.1)'
'd lterp(weightW.2(t=1),prec.1)'
'd lterp(weightMC.2(t=1),prec.1)'
'd lterp(weightST.2(t=1),prec.1)'
'd lterp(weightAS.2(t=1),prec.1)'
'disable fwrite'
'quit'
EOF

opengrads -lbc "run lterp.gs"


cat << EOT > ${DATAOUT}/G3D-EN-${nome}-w-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl 
dset ^G3D-EN-${nome}-w-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.bin
undef -9.99e33
title RAMS 4.2 Output
xdef   201 linear     -82.6250    0.2500
ydef   255 linear     -49.8750    0.2500
zdef    1 levels    1.
tdef   1 linear 12:00Z${admM24h}      1hr
vars   5
weightGR     0 99    - RAMS : weight for GR closure                   [        ]
weightW      0 99    - RAMS : weight for W closure                    [        ]
weightMC     0 99    - RAMS : weight for MC closure                   [        ]
weightST     0 99    - RAMS : weight for ST closure                   [        ]
weightAS     0 99    - RAMS : weight for AS closure  
endvars
EOT

    
# Funcao "data"

}

START_DATE=20060101
END_DATE=20060130

while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   loop ${START_DATE}

   rm lterp.gs

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done

