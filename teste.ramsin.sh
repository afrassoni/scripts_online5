#! /bin/sh -x

export PATH=$HOME/bin:$PATH

RUNDIR="."                           # Diretorio da rodada

VERSAO="4.3_kbcon_15"                 # Versao do CCATT-BRAMS
                                      # Opcoes: * 4.3_kbcon_15 => disparo convectivo original (CAPE) + 
                                      #                           15% redução fluxo de massa  
                                      #         * 4.3_kbcon    => disparo convectivo original (CAPE) 
                                      #         * 4.3_ecmwf    => disparo convectivo do ECMWF (Santos e Silva, 2009)
                                      #         * 4.3_kbcon_fa => disparo convectivo original (CAPE) + 
                                      #                           ensemble com membros objetivamente ponderados

#cd /scratch1/grupos/catt-brams/home/ariane.frassoni

############### DIRECTORY SETTINGS ######################
#      yyyymmddhhmn

tstart=200412011200
tfinal=200412021200

incr="24 hour" # Incremento para inicializacao
TIMMAX=24.
FRQANL=1200. #10800.

MAKESFC=1    # 1- Roda o MAKESFC, 0- Nao roda 
MAKEVFILE=1  # 1- Roda o MAKEVFILE, 0- Nao roda 

CLTYPE="EN" # AS GR MC LO SC EN
MOISTYPE='GPNR'
RAMSIN="RAMSIN-${VERSAO}-${CLTYPE}-sh"
ANO=`echo $tstart | cut -c 1-4`
ANLNAME="verao2005-oldENStrigg1-${CLTYPE}-${VERSAO}"

##############################################################
# Inicio do loop para uso na construcao dos diretorios

while [ $tstart -le $tfinal ]; do
   echo $tstart" "$tfinal

data=${tstart:0:8}

##############################################################
# Diretorios datain
DMODELSRC="${RUNDIR}/CCATT-BRAMS-${VERSAO}"
DSFC_IN='/scratch1/grupos/catt-brams/shared/datain/SURFACE_DATA'
DSMOIST_IN="${RUNDIR}/UMID/data/${MOISTYPE}/GL_SM.${MOISTYPE}"
DATMOS_IN="/scratch1/grupos/catt-brams/shared/datain/ATMOS_DATA/GLOBAL/GAMRAMT126/DP/${ANO}"
DEMISS='NONE'

# diretorios dataout
DSFC_OUT="${RUNDIR}/SFC"
DIVAR_OUT="${RUNDIR}/IVAR"
DHIS="${RUNDIR}/HIS"
DSMOIST_OUT="${RUNDIR}/UMID/output/GL_SM.${MOISTYPE}"; mkdir -p ${DSMOIST_OUT}
DANL="${RUNDIR}/ANL/rodada_longa/ANL_${CLTYPE}/${data}"; mkdir -p ${DANL}

############################################################
# Inicio do Ciclo

echo "iniciando CICLO em" $tstart


   if [ ${MAKESFC} -eq 1 ];then
      irun=1
   else
      irun=2
   fi

   if [ ${MAKEVFILE} -eq 1 ]; then
      irun=2
   else
      irun=3
   fi

   while [ "$irun" -le 3 ]; do

      case $irun in
         1) runtype=MAKESFC
            nproc=26
            CATT=ccatt_brams
            flag=0;;
         2) runtype=MAKEVFILE
            nproc=26 
            CATT=ccatt_brams;;
         3) runtype=INITIAL
            nproc=26
            CATT=ccatt_brams;;
      esac

# para uso do ciclo com recycle
      time=$tstart

# remove soil-moisture file
      rm -f $DSMOIST_OUT/GL_SM*.mod

      nvp=11

      year=${time:0:4}
      cmes=${time:4:2}
      cday=${time:6:2}
      chou=${time:8:4}

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

       echo " Iniciando rodada ...."
       echo " RUNTYPE : $runtype"
       echo " DATA    : $year-$cmes-$cday-$chou"
       echo " Submetendo CCATT-BRAMS ..."
       echo " time aprun -m 2Mhs -b -ss -n ${nproc} -N 1 /scratch1/grupos/catt-brams/home/ariane.frassoni/ccatt-brams${VERSAO} -f ${RAMSIN}_${runtype}-$year-$cmes-$cday-$chou : -n ${nproc} -d 1 -N 24 /scratch1/grupos/catt-brams/ariane.frasoni/ccatt-brams${VERSAO} -f ${RAMSIN}_${runtype}-$year-$cmes-$cday-$chou"
 
       
      time aprun -m 2Mhs -b -ss -n ${nproc} -N 1 /scratch1/grupos/catt-brams/home/ariane.frassoni/ccatt-brams${VERSAO} -f ${RAMSIN}_${runtype}-$year-$cmes-$cday-$chou : -n ${nproc} -d 1 -N 24 /scratch1/grupos/catt-brams/ariane.frasoni/ccatt-brams${VERSAO} -f ${RAMSIN}_${runtype}-$year-$cmes-$cday-$chou


      irun=$((irun + 1))

   done

   tstart=`inctime $tstart +$incr yyyymmddhhmn`

done

