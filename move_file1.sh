#! /bin/sh -x
#=================================================
# Funcao para fazer o backup
#

function backup() {
file=${1}
size=${2}
dir=${3}

tam=`du -sk ${file} | awk '{print $1}' `
if [ $tam -ge ${size} ];then
	mv -v ${file} ${dir}
else
   echo " Tamanho Inesperado : $size"
   echo "esperando 1 minuto para mover o arquivo"
	sleep 1m
	backup ${file} ${size} ${dir}
fi
}
#==================================================

tstart=2010010100
tfinal=2010011800
incr="24 hour"
CLTYPE="AS"
entr="novo"


DATAIN=/scratchin/grupos/catt-brams/home/ariane.frassoni/G3D/anl/ANL_${CLTYPE}
DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/G3D/ANL/${entr}_entranhamento/ANL_${CLTYPE}; mkdir -p ${DATAOUT}

while [ $tstart -le $tfinal ];do
   
   time=${tstart:0:8}

   if [ ! -e ${DATAOUT}/${time} ];then mkdir -p ${DATAOUT}/${time};fi

   if [ -e ${DATAIN}/${time} ];then 
      nfile=`ls -1 ${DATAIN}/${time}/* | wc -l`
   else
      nfile=0
   fi

   if [ ${nfile} == 22 ]; then

	ls -1 ${DATAIN}/${time}/*.vfm | while read file; do
		backup ${file} 617952 ${DATAOUT}/${time}
	done

	ls -1 ${DATAIN}/${time}/*.txt | while read file; do
		backup ${file} 75 ${DATAOUT}/${time} 
	done

 	tstart=`inctime ${tstart} +${incr} yyyymmddhh`

   else

        sleep 1m

   fi
      

done

