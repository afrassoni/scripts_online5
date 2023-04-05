#!/bin/ksh

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
DATAOUT=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/resultados/areas; mkdir -p ${DATAOUT}


#nome="fft1${d}"  # Nome dado para cada conjunto de pesos gerados com as simulacoes (ex: cte= simulacao com peso cte; fft1= simulacao do dia 01/01/2006; fft2= simulacao do dia 02/01/2006
#nome2="fft2-24h"  # Nome usado para diferenciar o primeiro do segundo ciclo de rodadas com os pesos (ex: fft24h eh a rodada gerando os pesos pela 1a vez para 24h; fft2-24h eh a rodada gerando os pesos por um segundo ciclo, para 24h)
#nome="cte"       # cte eh o nome dado as rodadas com o ciclo usando peso=cte
nome="fft01"

set -A cls MC LO KF GR AS EN   
set -A apr aprmc aprw aprst aprgr apras acccon 

v=0

while [ $v -le 5 ]; do

  CLTYPE=${cls[$v]}
  echo $CLTYPE

#Gera indices estatisticos medios nas 25 areas pequenas (divide AS em 25 areas iguais)

cat << EOF > gera.area.gs
'reinit'
'open ${DIROBS}/prec_${yyyymmddOBS}.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-${CLTYPE}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'

'define dif=${apr[$v]}.2(t=1)-prec.1(t=1)'
#      wr=write('tabela_RMS_${CLTYPE}_${nome}.txt', ${yyyyM24h}${mmM24h}${ddM24h}, append)
#      wr=write('tabela_RMS_${CLTYPE}_${nome}.txt', 'xi          xe          yi         ye         Bias          RMS', append)

x=1
while (x<=201)
   if (x+39 > 201)
      break
   endif
   y=1
   while(y<=255)
      if (y+50 > 255)
         break
      endif
      'define mdif=aave(dif,x='x',x='x+39',y='y',y='y+50')'
      'define rms=sqrt(aave(dif*dif,x='x',x='x+39',y='y',y='y+50'))'
      'd mdif'
       m1=subwrd(result,4)
      'd rms'
       m2=subwrd(result,4)
      wr=write('tabela_RMS_${CLTYPE}_${nome}.txt', x'          'x+39'          'y'           'y+50'           'm1'         'm2, append)
      y=y+51
   endwhile
   x=x+40
endwhile
'quit'
EOF


opengrads -lbc "gera.area.gs"


#Gera indices estatisticos medios sobre a AS

cat << EOF > gera.area.gs
'reinit'
'open ${DIROBS}/prec_${yyyymmddOBS}.ctl'
'open ${DATAIN}/G3D-EN-${nome}-apr-${CLTYPE}-A-${yyyyM24h}-${mmM24h}-${ddM24h}-120000-g1.ctl'

'define dif=${apr[$v]}.2(t=1)-prec.1(t=1)'
#  wr=write('tabela_RMS_${CLTYPE}_${nome}_AS.txt','Data       &     Bias     &     RMS', append)

'define mdif=aave(dif,x=1,x=201,y=1,y=255)'
'define rms=sqrt(aave(dif*dif,x=1,x=201,y=1,y=255))'
'd mdif'
  m1=subwrd(result,4)
'd rms'
  m2=subwrd(result,4)
  wr=write('tabela_RMS_${CLTYPE}_${nome}_AS.txt','${yyyyM24h}${mmM24h}${ddM24h}   &  '  m1'    &   'm2, append)
'quit'
EOF


opengrads -lbc "gera.area.gs"

     

 v=$((v+1))
done

# Funcao "data"

}

START_DATE=20060101
END_DATE=20060131

#   rm -fr tabela_RMS*.txt
 
while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   

   loop ${START_DATE}

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done

