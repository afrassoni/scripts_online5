#! /bin/sh

# Este script puxa a sst no novo formato (oisst.????????, versao 2) e executa
# o programa sst2RAMS.x o qual escreve no formato do RAMS.

# Demerval S. Moreira - 11/Nov/2002

# sintaxe:  get_sst.sh data DIR_out 
#
# onde:    data = Data no formato YYYYMMDD, onde o dia (DD) eh sempre numa quarta-feira. 
#               = auto => Pega o arquivo mais recente que encontra-se no site. 
#       DIR_out = Diretorio de saida da sst no formato RAMS.
#               = auto => $DIR

DIR=/rede/tupa_tempo/externos/Download/BRAMS/SST/201207
DIR2=/nas4/poluicao/surface_data/sst_global_semanal/D/2005

aa=`date +%Y`
mm=`date +%m`

dd=`date +%d`
dd1=`date +%d --date '1 days ago'`
#executa na quinta copiando os dados de quarta-feira

data=$aa$mm$dd1

ic=1
while [ $ic -le 39 ]
do
if [ $ic -eq 1 ];  then data=20050105 ;fi 
if [ $ic -eq 2 ];  then data=20050112 ;fi
if [ $ic -eq 3 ];  then data=20050119 ;fi
if [ $ic -eq 4 ];  then data=20050126 ;fi
if [ $ic -eq 5 ];  then data=20050202 ;fi
if [ $ic -eq 6 ];  then data=20050209 ;fi
if [ $ic -eq 7 ];  then data=20050216 ;fi
if [ $ic -eq 8 ];  then data=20050223 ;fi
if [ $ic -eq 9 ];  then data=20050302 ;fi
if [ $ic -eq 10 ]; then data=20050309 ;fi
if [ $ic -eq 11 ]; then data=20050316 ;fi
if [ $ic -eq 12 ]; then data=20050323 ;fi
if [ $ic -eq 13 ]; then data=20050330 ;fi
if [ $ic -eq 14 ]; then data=20050406 ;fi
if [ $ic -eq 15 ]; then data=20050413 ;fi
if [ $ic -eq 16 ]; then data=20050420 ;fi
if [ $ic -eq 17 ]; then data=20050427 ;fi
if [ $ic -eq 18 ]; then data=20050504 ;fi
if [ $ic -eq 19 ]; then data=20050511 ;fi
if [ $ic -eq 20 ]; then data=20050518 ;fi
if [ $ic -eq 21 ]; then data=20050525 ;fi 
if [ $ic -eq 22 ]; then data=20050601 ;fi
if [ $ic -eq 23 ]; then data=20050608 ;fi
if [ $ic -eq 24 ]; then data=20050615 ;fi
if [ $ic -eq 25 ]; then data=20050622 ;fi
if [ $ic -eq 26 ]; then data=20050629 ;fi
if [ $ic -eq 27 ]; then data=20050706 ;fi
if [ $ic -eq 28 ]; then data=20050713 ;fi
if [ $ic -eq 29 ]; then data=20050720 ;fi
if [ $ic -eq 30 ]; then data=20050727 ;fi
if [ $ic -eq 31 ]; then data=20050803 ;fi
if [ $ic -eq 32 ]; then data=20050810 ;fi
if [ $ic -eq 33 ]; then data=20050817 ;fi
if [ $ic -eq 34 ]; then data=20050824 ;fi
if [ $ic -eq 35 ]; then data=20050831 ;fi
if [ $ic -eq 36 ]; then data=20050907 ;fi
if [ $ic -eq 37 ]; then data=20050914 ;fi
if [ $ic -eq 38 ]; then data=20050921 ;fi
if [ $ic -eq 39 ]; then data=20050928 ;fi
if [ $ic -eq 40 ]; then data=          ;fi
if [ $ic -eq 41 ]; then data=          ;fi
if [ $ic -eq 42 ]; then data=          ;fi
if [ $ic -eq 43 ]; then data=          ;fi
if [ $ic -eq 44 ]; then data=          ;fi
if [ $ic -eq 45 ]; then data=          ;fi
if [ $ic -eq 46 ]; then data=          ;fi
if [ $ic -eq 47 ]; then data=          ;fi
if [ $ic -eq 48 ]; then data=          ;fi
if [ $ic -eq 49 ]; then data=          ;fi
if [ $ic -eq 50 ]; then data=          ;fi
if [ $ic -eq 51 ]; then data=          ;fi
if [ $ic -eq 52 ]; then data=          ;fi

DIR_out=$DIR2

if [ x$data = "x" ]; then
  echo -n "Entre com a data (YYYYMMDD, DD-> quarta-feira)=> "
  read data 
fi

if [ x$DIR_out = "x" ]; then
  echo -n "Entre com o diretorio de saida=> "
  read DIR_out 
fi


if [ $DIR_out = "auto" ]; then DIR_out=$DIR/RAMS;else DIR=$DIR_out; fi
if test ! -s $DIR_out; then mkdir $DIR_out; fi
if test ! -s $DIR_out; then echo "Nao existe o diretorio $DIR_out, saindo..."; exit; fi


if [ $data = "auto" ]; then
cat << Eof | ftp -in ftpprd.ncep.noaa.gov > $DIR/list
user anonymous sfreitas@cptec.inpe.br
cd /pub/cmb/sst/oisst_v2/
lcd $DIR
dir oisst.*
bye
Eof
file=`tail -1 $DIR/list | awk '{print $9}'`
data=`echo $file | awk '{print substr($1,7,8)}'`
fi

if test ! -s $DIR2/oisst.${data}*; then
echo "Nao existe o arquivo $DIR2/oisst.${data}* tentando baixar do site"
cat << Eof | ftp -in ftpprd.ncep.noaa.gov > $DIR/list
user anonymous sfreitas@cptec.inpe.br
cd /pub/cmb/sst/oisst_v2/
lcd $DIR
bin
mget oisst.${data}* 
dir
bye
Eof
else
  if [ $DIR = $DIR_out ]; then cp $DIR2/oisst.${data}* $DIR; fi
fi

if test ! -s $DIR/oisst.${data}*; then
  echo "Nao existe o arquivo $DIR/oisst.${data}, saindo..."
  echo
  echo "Arquivos existentes no site:"
  cat $DIR/list | grep oisst
  echo
  echo "Arquivos existentes em $DIR2:"
  ls $DIR2 | grep oisst
  exit
fi   

if [ $DIR != $DIR_out ]; then cp $DIR/oisst.${data}* $DIR_out; fi
if test -s $DIR_out/oisst.${data}*.gz; then gunzip $DIR_out/oisst.${data}*.gz; fi

cd $DIR_out
echo "Gerando a sst do dia=>" $data
echo
mes=`echo $data | awk '{print substr($1,5,2)}'`
if [ $mes = "01" ]; then mes="JAN"; fi
if [ $mes = "02" ]; then mes="FEB"; fi
if [ $mes = "03" ]; then mes="MAR"; fi
if [ $mes = "04" ]; then mes="APR"; fi
if [ $mes = "05" ]; then mes="MAY"; fi
if [ $mes = "06" ]; then mes="JUN"; fi
if [ $mes = "07" ]; then mes="JUL"; fi
if [ $mes = "08" ]; then mes="AUG"; fi
if [ $mes = "09" ]; then mes="SEP"; fi
if [ $mes = "10" ]; then mes="OCT"; fi
if [ $mes = "11" ]; then mes="NOV"; fi
if [ $mes = "12" ]; then mes="DEC"; fi

echo "Arquivo do mes de "$mes
echo
$DIR2/sst2RAMS.x $DIR_out/oisst.${data} ${data}


#if test -s $DIR_out/oisst.${data}; then rm -f $DIR_out/oisst.${data}; fi

echo "Criando o arquivo WHEADER..."

ls -1 *90S180W > $DIR_out/list
nsem=`cat $DIR_out/list | wc -l`
nsem=`expr $nsem + 0`

echo "  180  181  -90 -180 -0.500000 -0.500000" > $DIR_out/WHEADER
echo "     $nsem" >> $DIR_out/WHEADER
i=1
while [ $i -le $nsem ]; do
  data2=`head -$i $DIR_out/list | tail -1 | awk '{print substr($1,2,8)}'`
  ano=`echo $data2 | awk '{print substr($1,1,4)}'`
  mes=`echo $data2 | awk '{print substr($1,5,2)}'`
  dia=`echo $data2 | awk '{print substr($1,7,2)}'`
  echo "$data2 0000   $mes   $dia   00" >> $DIR_out/WHEADER
  i=`expr $i + 1`
done  
echo "" >> $DIR_out/WHEADER
echo "(bksz   NO  lat  lon   iofflat   iofflon)" >> $DIR_out/WHEADER
echo "(ntimes)" >> $DIR_out/WHEADER
echo "(fpfx year  mon date hour)" >> $DIR_out/WHEADER
#meses="

ic=`expr $ic + 1`
done
