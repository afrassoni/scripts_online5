#! /bin/bash -x


#
# -- Inicializando Modules Environment
#

source /opt/modules/default/etc/modules.sh

#
# -- Exportando pasta $HOME/bin para o $PATH
#

export PATH=$HOME/bin:$PATH

#
# -- Definindo alguns parametros
#

RUNDIR=`pwd`             # Diretorio da rodada

VERSAO="4.3_kbcon"            # Versao do CCATT-BRAMS
                         # Opcoes: kb15: 4.3_kbcon_15 => disparo convectivo original (CAPE) + 
                         #                         15% reducaoo fluxo de massa  
                         #         4.3_kbcon    => disparo convectivo original (CAPE) 
                         #         4.3_ecmwf    => disparo convectivo do ECMWF (Santos e Silva, 2009)
                         #         4.3_kbcon_fa => disparo convectivo original (CAPE) + 
                         #                         ensemble com membros objetivamente ponderados
                         #         pesos        => disparo convectivo original (CAPE) + 15% reducaoo fluxo de massa
                         #                         + inclusao de pesos (firefly) no fluxo de massa
############### PARAMETER SETTINGS ################################################

tstart=200612011200      # Ex: YYYYMMDDHHMnMn
tfinal=200612311200
incr="24 hour"           # Inicialization increment
TIMMAX=48.               # Max time to run
FRQANL=86400. #10800.    # ANL frequency (RAMSIN)
ISANINC=1200             # ISAN processing increment (MAKEVFILE)

MAKESFC=0                # 1- Run MAKESFC,   0- No run  
MAKEVFILE=1              # 1- Run MAKEVFILE, 0- No run  

CLTYPE="EN"              # Choose the closure type of convecive parameterization
                         # AS - Arakawa and Shubert (1974)
                         # GR - Grell (1993)
                         # MC - Moisture convergence (Kuo, 1974)
                         # LO - Low-level Omega (Frank and Coen, 1986)
                         # SC - Like Kain and Fritsch (1994)
                         # EN - ensemble simple mean 

MOISTYPE='GPNR'          # Moisture data prefix

####################################################################################

RAMSIN="RAMSIN-${VERSAO}-${CLTYPE}-sh"                          # Ramsin name
#ANLNAME="verao2005-oldENStrigg1-${CLTYPE}-${VERSAO}" 
ANLNAME="oEt1-${CLTYPE}-${VERSAO}" 

cd ${RUNDIR}

# Loop start 

while [ $tstart -le $tfinal ]; do
   echo $tstart" "$tfinal

data=${tstart:0:8}
ANO=${tstart:0:4}

################DSMOIST_OUT####################################################################
#SMOIST_OUT

# Directories: datain
DMODELSRC="${RUNDIR}/CCATT-BRAMS-4.3"                              # Model source                                         
DSFC_IN='sfd'                                                      # Surface data 
DSMOIST_IN="umd/data/${MOISTYPE}/${ANO}/GL_SM.${MOISTYPE}"         # Moisture data
DATMOS_IN="dpshare/${ANO}"                                         # Path of DPs
DEMISS='NONE'                                                      # Emission dir

# diretories dataout
DSFC_OUT="${RUNDIR}/sfc"                                           # SFC output
DIVAR_OUT="${RUNDIR}/ivar"                                         # IVAR output
DHIS="${RUNDIR}/his"                                               # History output
DSMOIST_OUT="umd/output/GL_SM.${MOISTYPE}"; mkdir -p ${DSMOIST_OUT}# Moisture output
DANL="${RUNDIR}/anl/ANL_${CLTYPE}_orig/${data}"; mkdir -p ${DANL}  # ANL output
LOG="${RUNDIR}/logs"                                               # Log output

############################################################
# Inicio do Ciclo

echo "iniciando CICLO em" $tstart


   if [ ${MAKESFC} -eq 1 ];then
      irun=1
   elif [ ${MAKEVFILE} -eq 1 ];then
      irun=2
   else
      irun=3
   fi

   while [ "$irun" -le 3 ]; do

      case $irun in
         1) runtype=MAKESFC
            walltime="00:30:00"
            nproc=1
            mppwidth=24
            mppnppn=24
            CATT=ccatt_brams
            flag=0
            PBS_SERVER=sdb
            MAKESFC=0
            MAKEVFILE=1
#            module swap tupa aux
            ;;
         2) runtype=MAKEVFILE
            walltime="00:30:00"
            nproc=1
            mppwidth=24
            mppnppn=24
            CATT=ccatt_brams
            PBS_SERVER=sdb
#            module swap tupa aux 
            ;;
         3) runtype=INITIAL
            walltime="01:00:00"
            nproc=240
            mppwidth=${nproc}
            mppnppn=24
            CATT=ccatt_brams
            PBS_SERVER=sdb
#            module swap aux tupa
            ;;
      esac

# remove soil-moisture file
      rm -f ${DSMOIST_OUT}/GL_SM*.mod

      nvp=11

      year=${tstart:0:4}
      cmes=${tstart:4:2}
      cday=${tstart:6:2}
      chou=${tstart:8:4}

      sed "s,#runtype#,$runtype,g" ramsin.template > ${RAMSIN}_${runtype}

      sed -i "s,#chou#,$chou,g" ${RAMSIN}_${runtype}
      sed -i "s,#cmes#,$cmes,g" ${RAMSIN}_${runtype}
      sed -i "s,#cday#,$cday,g" ${RAMSIN}_${runtype}
      sed -i "s,#year#,$year,g" ${RAMSIN}_${runtype}
      sed -i "s,#timmax#,$TIMMAX,g" ${RAMSIN}_${runtype}
      sed -i "s,#FRQANL#,$FRQANL,g" ${RAMSIN}_${runtype}
      sed -i "s,#CLTYPE#,$CLTYPE,g" ${RAMSIN}_${runtype}
      sed -i "s,#DIVAR_OUT#,$DIVAR_OUT,g" ${RAMSIN}_${runtype}
      sed -i "s,#DHIS#,$DHIS,g" ${RAMSIN}_${runtype}
      sed -i "s,#DANL#,$DANL,g" ${RAMSIN}_${runtype}
      sed -i "s,#DSFC_OUT#,$DSFC_OUT,g" ${RAMSIN}_${runtype}
      sed -i "s,#DSFC_IN#,$DSFC_IN,g" ${RAMSIN}_${runtype}
      sed -i "s,#DSMOIST_IN#,$DSMOIST_IN,g" ${RAMSIN}_${runtype}
      sed -i "s,#DSMOIST_OUT#,$DSMOIST_OUT,g" ${RAMSIN}_${runtype}
      sed -i "s,#DATMOS_IN#,$DATMOS_IN,g" ${RAMSIN}_${runtype}
      sed -i "s,#DMODELSRC#,$DMODELSRC,g" ${RAMSIN}_${runtype}
      sed -i "s,#DEMISS#,$DEMISS,g" ${RAMSIN}_${runtype}
      sed -i "s,#ANLNAME#,$ANLNAME,g" ${RAMSIN}_${runtype}
      sed -i "s,#ISANINC#,$ISANINC,g" ${RAMSIN}_${runtype}

      echo " Iniciando rodada ...."
      echo " RUNTYPE : $runtype"
      echo " DATA    : $year-$cmes-$cday-$chou"
      echo " Submetendo CCATT-BRAMS ..."


       echo " aprun -n ${nproc} ${RUNDIR}/${VERSAO} -f ${RAMSIN}_${runtype} > ${LOG}/${RAMSIN}_${runtype}-$year-$cmes-$cday-$chou.out"

cat << EOF > qsub_brams
#! /bin/bash -x
#PBS -l walltime=${walltime}
#PBS -l mppwidth=${mppwidth}
#PBS -l mppdepth=1
#PBS -l mppnppn=${mppnppn}
#PBS -A CPTEC
#PBS -N ccatt
#PBS -j oe
#PBS -o ${RUNDIR}/logs/teste.o
#PBS -e ${RUNDIR}/logs/teste.e
#PBS -m bae
#PBS -M ariane.frassoni@cptec.inpe.br

cd ${RUNDIR}
export PBS_SERVER=${PBS_SERVER}
export OMP_NUM_THREADS=1
ulimit -s unlimited
ulimit -c unlimited


time aprun -n ${nproc} ${RUNDIR}/${VERSAO} -f ${RAMSIN}_${runtype} > ${LOG}/${RAMSIN}_${runtype}-$year-$cmes-$cday-$chou.out
touch .terminou

EOF

      if [ -e .terminou ]; then rm -fr .terminou;fi

      qsub -q pesq qsub_brams

      until [ -e .terminou ];do sleep 1s; done
      rm -fr .terminou
      rm -fr qsub_brams

      irun=$((irun + 1))

   done

   tstart=`${HOME}/bin/inctime $tstart +$incr yyyymmddhhmn`

done

