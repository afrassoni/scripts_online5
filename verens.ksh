#!/bin/ksh

#
# Calcula a media do ensemble e compara com a soma dos fechamentos multiplicados pelos pesos
#

loop( ) {

# Definindo variaveis de datas
yyyy=`echo ${START_DATE} |cut -c 1-4`   # ano
mm=`echo ${START_DATE} |cut -c 5-6`     # mes
dd=`echo ${START_DATE} |cut -c 7-8`     # dia
hh=`echo ${START_DATE} |cut -c 9-10`    # hora
amd=`echo ${START_DATE} |cut -c 1-8`    # amd= ano mes dia
d=`echo ${START_DATE} |cut -c 8-8`      # digito usado na variavel $nome

yyyymmOBS=`date +%Y%m -d "${amd} 1 days"`       # ano mes da observacao
yyyymmddOBS=`date +%Y%m%d -d "${amd} 1 days"`   # ano mes dia da observacao

yyyymmddM24h=`date +%Y%m%d -d "${amd} 1 days"`  # ano mes dia da simulaca de 24h
yyyyM24h=`echo ${yyyymmddM24h} |cut -c 1-4`     # ano da simulacao de 24h
mmM24h=`echo ${yyyymmddM24h} |cut -c 5-6`       # mes da simulacao de 24h
ddM24h=`echo ${yyyymmddM24h} |cut -c 7-8`       # dia da simulacao de 24h

DATAIN=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/${yyyy}${mm}${dd}
DIROBS=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/obs/${yyyymmOBS}
DATAOUT=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/resultados/novo_entranhamento/${yyyy}${mm}${dd}
DIRPESOS=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/pesos/${yyyy}${mm}${dd}

nome="fft01"

cat << EOF > verens.gs
'reinit'
'open ${DATAIN}/G3D-EN-${nome}-apr-MC-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-LO-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-KF-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-AS-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-GR-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-EN-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'
'open ${DIROBS}/prec_${yyyymmddOBS}.ctl'
'open ${DIRPESOS}/G3D-EN-${nome}-w-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'

'set display color white'
'c'
'set mpdset brmap mres'
'set grads off'
'color.gs -2 2 0.5 -kind red->white->blue' 


'define sclos=(aprmc.1*weightMC.8)+(aprw.2*weightW.8)+(aprst.3*weightST.8)+(apras.4*weightAS.8)+(aprgr.5*weightGR.8)'
'define difen=sclos-acccon.6'
'd difen'
'cbarn.gs'
'draw title Diferenca entre Soma dos fechamentos e Ensemble \ ${yyyyM24h}-${mmM24h}-${ddM24h}'
'printim dif-${nome}-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.gif'

'define mobs=aave(prec.7,x=1,x=201,y=1,y=255)'
'define msclos=aave(sclos,x=1,x=201,y=1,y=255)'
'define mens=aave(acccon.6,x=1,x=201,y=1,y=255)'
'define mdif=aave(difen,x=1,x=201,y=1,y=255)'
'define porc=((msclos*100)/mens)-100'

'd mobs'
m0=subwrd(result,4)

'd msclos'
m1=subwrd(result,4)

'd mens'
m2=subwrd(result,4)

'd mdif'
m3=subwrd(result,4)

'd porc'
m4=subwrd(result,4)

wr=write('confere_ens_${nome}_AS.txt','${yyyyM24h}${mmM24h}${ddM24h}   'm0'     'm1'     'm2'     'm3'    'm4, append)

'quit'
EOF


opengrads -lbc "verens.gs"


# Funcao "data"

}

START_DATE=20060101
END_DATE=20060130

#   rm -fr tabela_RMS*.txt
 
while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   

   loop ${START_DATE}

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done

