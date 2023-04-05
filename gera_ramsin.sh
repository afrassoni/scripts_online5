#!/bin/sh -x

RUNDIR="."               # Diretorio da rodada
VERSAO="4.3_kbcon_15"    # Versao do CCATT-BRAMS
                         # Opcoes: 4.3_kbcon_15 => disparo convectivo original (CAPE) + 
                         #                           15% reducaoo fluxo de massa  
                         #         4.3_kbcon    => disparo convectivo original (CAPE) 
                         #         4.3_ecmwf    => disparo convectivo do ECMWF (Santos e Silva, 2009)
                         #         4.3_kbcon_fa => disparo convectivo original (CAPE) + 
                         #                           ensemble com membros objetivamente ponderados

############### PARAMETER SETTINGS ################################################

tstart=200412011200      # Ex: YYYYMMDDHHMnMn
tfinal=200412011200
incr="24 hour"           # Inicialization increment
TIMMAX=24.               # Max time to run
FRQANL=1200. #10800.     # ANL frequency (RAMSIN)
CLTYPE="EN"              # Choose the closure type of convecive parameterization
                         # AS - Arakawa and Shubert (1974)
                         # GR - Grell (1993)
                         # MC - Moisture convergence (Kuo, 1974)
                         # LO - Low-level Omega (Frank and Coen, 1986)
                         # SC - Like Kain and Fritsch (1994)
                         # EN - ensemble simple mean 
MOISTYPE='GPNR'          # Moisture data prefix

####################################################################################

RAMSIN="RAMSIN-${VERSAO}-${CLTYPE}-sh"                 # Ramsin name
ANLNAME="verao2005-oldENStrigg1-${CLTYPE}-${VERSAO}" 
ANO=${tstart:0:4}

# Loop start 

while [ $tstart -le $tfinal ]; do
   echo $tstart" "$tfinal

data=${tstart:0:8}

####################################################################################

# Directories: datain

DMODELSRC="${RUNDIR}/CCATT-BRAMS-4.3"                                                          # Model source                                         
DSFC_IN='/scratch1/grupos/catt-brams/shared/datain/SURFACE_DATA'                               # Surface data 
DSMOIST_IN="${RUNDIR}/UMID/data/${MOISTYPE}/GL_SM.${MOISTYPE}"                                 # Moisture data
DATMOS_IN="/scratch1/grupos/catt-brams/shared/datain/ATMOS_DATA/GLOBAL/GAMRAMT126/DP/${ANO}"   # Path of DPs
DEMISS='NONE'                                                                                  # Emission dir

# diretorios dataout
DSFC_OUT="${RUNDIR}/SFC"                                                                       # SFC output
DIVAR_OUT="${RUNDIR}/IVAR"                                                                     # IVAR output
DHIS="${RUNDIR}/HIS"                                                                           # History output
DSMOIST_OUT="${RUNDIR}/UMID/output/GL_SM.${MOISTYPE}"; mkdir -p ${DSMOIST_OUT}                 # Moisture output
DANL="${RUNDIR}/ANL/rodada_longa/ANL_${CLTYPE}/${data}"; mkdir -p ${DANL}                      # ANL output
LOG="${RUNDIR}/logs"                                                                           # Log output

time=$tstart


      nvp=11

      year=${time:0:4}
      cmes=${time:4:2}
      cday=${time:6:2}
      chou=${time:8:4}

      sed "s,#runtype#,#runtype#,g" ramsin.template > ./ramsin/${RAMSIN}_${runtype}_${time}

      sed -i "s,#chou#,$chou,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#cmes#,$cmes,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#cday#,$cday,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#year#,$year,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#timmax#,$TIMMAX,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#FRQANL#,$FRQANL,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#CLTYPE#,$CLTYPE,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DIVAR_OUT#,$DIVAR_OUT,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DHIS#,$DHIS,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DANL#,$DANL,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DSFC_OUT#,$DSFC_OUT,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DSFC_IN#,$DSFC_IN,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DSMOIST_IN#,$DSMOIST_IN,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DSMOIST_OUT#,$DSMOIST_OUT,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DATMOS_IN#,$DATMOS_IN,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DMODELSRC#,$DMODELSRC,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#DEMISS#,$DEMISS,g" ./ramsin/${RAMSIN}_${runtype}_${time}
      sed -i "s,#ANLNAME#,$ANLNAME,g" ./ramsin/${RAMSIN}_${runtype}_${time}

   tstart=`/stornext/home/ariane.frassoni/bin/inctime $tstart +$incr yyyymmddhhmn`

done



