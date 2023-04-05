#!/bin/ksh

# calcula norma dos pesos

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

DATAIN=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/arqctl
DATAOUT=/scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/resultados
echo ${DATAIN}

cat << EOF > ffrms.gs
'reinit'
'open ${DATAIN}/fft01.ctl'
'open ${DATAIN}/fft02.ctl'
'open ${DATAIN}/fft03.ctl'
'open ${DATAIN}/fft04.ctl'
'open ${DATAIN}/fft05.ctl'



ti=1
tf=5

while(ti<=tf)

'define dif0=sqrt(((w.1(t='ti')-0.2)*(w.1(t='ti')-0.2)))'
'define dif1=sqrt(((w.2(t='ti')-w.1(t='ti'))*(w.2(t='ti')-w.1(t='ti'))))'
'define dif2=sqrt(((w.3(t='ti')-w.2(t='ti'))*(w.3(t='ti')-w.2(t='ti'))))'
'define dif3=sqrt(((w.4(t='ti')-w.3(t='ti'))*(w.4(t='ti')-w.3(t='ti'))))'
'define dif4=sqrt(((w.5(t='ti')-w.4(t='ti'))*(w.5(t='ti')-w.4(t='ti'))))'


'define mdif0=aave(dif0,x=1,x=201,y=1,y=255)'
'define mdif1=aave(dif1,x=1,x=201,y=1,y=255)'
'define mdif2=aave(dif2,x=1,x=201,y=1,y=255)'
'define mdif3=aave(dif3,x=1,x=201,y=1,y=255)'
'define mdif4=aave(dif4,x=1,x=201,y=1,y=255)'


'd mdif0'
  m0=subwrd(result,4)

'd mdif1'
  m1=subwrd(result,4)

'd mdif2'
  m2=subwrd(result,4)

'd mdif3'
  m3=subwrd(result,4)

'd mdif4'
  m4=subwrd(result,4)


  wr=write('norma_pesos_AS.txt', m0'      'm1'     'm2'     'm3'     'm4 , append)

ti=ti+1

endwhile

'quit'
EOF


opengrads -lbc "ffrms.gs"

     


# Funcao "data"

}

START_DATE=20060101
END_DATE=20060101

#   rm -fr tabela_RMS*.txt
 
while [ ${START_DATE} -le ${END_DATE} ];do
   echo "Start Date: ${START_DATE}"
   echo "End Date  : ${END_DATE}"
   

   loop ${START_DATE}

   START_DATE=`date +%Y%m%d -d "${START_DATE} 1 days"`

done

