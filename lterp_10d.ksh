#!/bin/ksh

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


nome="ensfis"

set -A cls MC LO KF GR AS EN
#set -A apr APRMC APRW APRST APRGR APRAS acccon
set -A apr acccon acccon acccon acccon acccon

v=0

while [ $v -le 0 ]; do

  CLTYPE=${cls[$v]}
  echo ${CLTYPE}

 
    DIRMODEL=/stornext/grupos/catt-brams/ariane.frassoni/G3D/ramspost/novo_entranhamento/ANL_${CLTYPE}/${yyyy}${mm}${dd}
    DIROBS=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/${yyyymmOBS}
    DATAOUT=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/ANL_${CLTYPE}/${yyyy}${mm}${dd}; mkdir -p ${DATAOUT}


cat << EOF > lterp.gs
'reinit'
'open ${DIROBS}/prec_${yyyymmddOBS}.ctl'
'q dims'
rc=sublin(result,5)
lin=subwrd(rc,6)
day=substr(lin,4,5)
'define dayf='day'+10'

while(day<=dayf)
'open ${DIRMODEL}/G3D-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-'day'-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ${DATAOUT}/G3D-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-'day'-120000-g1.bin'
'd lterp(${apr[$v]}.2(t=1),prec.1)'
'disable fwrite'
day=day+1
endwhile
'quit'
EOF

echo "open ${DIRMODEL}/G3D-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl"

#opengrads -lbc "run lterp.gs"


cat << EOT > ${DATAOUT}/G3D-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl 
dset ^G3D-${CLTYPE}-${nome}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.bin
undef -9.99e33
title RAMS 4.2 Output
xdef   201 linear     -82.6250    0.2500
ydef   255 linear     -49.8750    0.2500
zdef    1 levels    1.
tdef   1 linear 12:00Z${admM24h}      1hr
vars   1
${apr[$v]}   0 99 - RAMS : acccum precip from ${cls[$v]} closure [mm]
endvars
EOT

     
 v=$((v+1))
done

# Funcao "data"

}

START_DATE=20060101
END_DATE=20060102

while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   loop ${START_DATE}

#   rm lterp.gs

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done

