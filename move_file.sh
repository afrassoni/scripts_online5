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

tstart=2006070200
tfinal=2006073100
incr="24 hour"
CLTYPE="AS"
nome="ensfis"
df1=74     # tamanho do arquivo txt
df2=733460 # tamanho do arquivo vfm
nf=34      # numero total de arquivos


DATAIN=/scratchin/grupos/catt-brams/home/ariane.frassoni/G3D/anl/ANL_${CLTYPE}
DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/ANL/ciclo_diurno/ANL_${CLTYPE}; mkdir -p ${DATAOUT}
#DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/experimentos/ANL/ANL_EN
#DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/ANL/novo_entranhamento/ANL_${CLTYPE}; mkdir -p ${DATAOUT}

while [ $tstart -le $tfinal ];do
   
   time=${tstart:0:8}

   if [ ! -e ${DATAOUT}/${time} ];then mkdir -p ${DATAOUT}/${time};fi

   if [ -e ${DATAIN}/${time} ];then 
      nfile=`ls -1 ${DATAIN}/${time}/*${nome}* | wc -l`
   else
      nfile=0
   fi

   if [ ${nfile} == ${nf} ]; then

	ls -1 ${DATAIN}/${time}/*${nome}*.vfm | while read file; do
		backup ${file} ${df2} ${DATAOUT}/${time}
	done

	ls -1 ${DATAIN}/${time}/*${nome}*.txt | while read file; do
		backup ${file} ${df1} ${DATAOUT}/${time} 
	done

 	tstart=`inctime ${tstart} +${incr} yyyymmddhh`

   else

        sleep 1m

   fi
      

done

