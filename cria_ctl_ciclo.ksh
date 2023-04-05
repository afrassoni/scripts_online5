# cria os arquivos *.ctl para os arquivos gerados com o script interp_chuva_novo.gs

CLTYPE=EN
varm="precip"
obs="trmm"
#v orig: nome="GD-precip-${CLTYPE}-ensfisciclofy30-A"
nome="GD-avaliacao-e1-precip-${CLTYPE}-ensfisciclofy30-A"

lterp(){

ANL=${1}
FCT=${2}

echo $ANL
echo $FCT

case ${obs} in
trmm) arqobs="3B42V7_${ANL:0:6}.ctl"
      var="r"
      xx="201"
      yy="255"
      xi="-82.625"
      yi="-49.875"
;;
merge) arqobs="prec_${ANL:0:6}.ctl"
       var="prec"
       xx="201" #"196"
       yy="255" #"250"
       xi="-82.6250" #"-82.8000"
       yi="-49.8750" #"-50.2000"
;;
esac

DIROBS=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs
#DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/${obs}/ANL_${CLTYPE}/${ANL:0:8}
DATAOUT=/stornext/grupos/catt-brams/ariane.frassoni/GD/experimentos/bin/${obs}/ANL_${CLTYPE}/${ANL:0:8}

data=`echo ${ANL} |cut -c 1-8`
datactl=`date +%d%b%Y -d "${data} 0 days"`


cat << EOF > ${DATAOUT}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.ctl
dset ^${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-${FCT:8:2}0000-g1.bin
undef -9.99e+08
xdef   ${xx} linear     ${xi}    0.2500
ydef   ${yy} linear     ${yi}    0.2500
zdef   1 levels    1.
tdef   1 linear 12:00Z${datactl}      1hr
vars 1
precip   0 0 daily precip  (mm/day)
ENDVARS
EOF

################ Ctls para o ciclo diurno acumulado #######################################
cat << EOF > /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/exp1-ciclo-obs-${FCT:0:4}${FCT:4:2}.ctl
dset ^exp1-ciclo-obs-${FCT:0:4}${FCT:4:2}.bin
undef -9.99e+08
xdef   ${xx} linear     ${xi}    0.2500
ydef   ${yy} linear     ${yi}    0.2500
zdef   1 levels    1.
tdef   8 linear 12:00Z${datactl}      3hr
vars 1
precip   0 0 daily precip  (mm/day)
ENDVARS
EOF

cat << EOF > /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/exp1-ciclo-mod-ensfis-${FCT:0:4}${FCT:4:2}.ctl
dset ^exp1-ciclo-mod-ensfis-${FCT:0:4}${FCT:4:2}.bin
undef -9.99e+08
xdef   ${xx} linear     ${xi}    0.2500
ydef   ${yy} linear     ${yi}    0.2500
zdef   1 levels    1.
tdef   8 linear 12:00Z${datactl}      3hr
vars 1
precip   0 0 daily precip  (mm/day)
ENDVARS
EOF

cat << EOF > /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/exp1-ciclo-mod-ensfisciclofy30-${FCT:0:4}${FCT:4:2}.ctl
dset ^exp1-ciclo-mod-ensfisciclofy30-${FCT:0:4}${FCT:4:2}.bin
undef -9.99e+08
xdef   ${xx} linear     ${xi}    0.2500
ydef   ${yy} linear     ${yi}    0.2500
zdef   1 levels    1.
tdef   8 linear 12:00Z${datactl}      3hr
vars 1
precip   0 0 daily precip  (mm/day)
ENDVARS
EOF

###########################################################################

cat << EOF > ${DATAOUT}/${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-template-g1.ctl
dset ^${nome}-${FCT:0:4}-${FCT:4:2}-${FCT:6:2}-g1.ctl
options template
undef -9.99e+08
xdef   ${xx} linear     ${xi}    0.2500
ydef   ${yy} linear     ${yi}    0.2500
zdef   1 levels    1.
tdef   12 linear 03:00Z${datactl}      3hr
vars 1
precip   0 0 daily precip  (mm/day)
ENDVARS
EOF




}

START_DATE=2008011303
END_DATE=2008011903
TMAX=36
INCR=24

while [ ${START_DATE} -le ${END_DATE} ];do

  Y=${START_DATE:0:4}
  M=${START_DATE:4:2}
  D=${START_DATE:6:2}
  H=${START_DATE:8:2}


  PSTART_DATE=${START_DATE}
#  INCMAX=$((TMAX-INCR))
  PEND_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00  33 hours"`
  PINCR=03
  while [ ${PSTART_DATE} -le ${PEND_DATE} ]; do

     PY=${PSTART_DATE:0:4}
     PM=${PSTART_DATE:4:2}
     PD=${PSTART_DATE:6:2}
     PH=${PSTART_DATE:8:2}


     lterp ${START_DATE} ${PSTART_DATE}

#     if [ ${START_DATE} -ne ${PSTART_DATE} ];then
#        NEXT_DATE=`date "+%Y%m%d%H" --date="${PY}-${PM}-${PD} ${PH}:00:00 24 hours"`
#     
#        echo "lterp ${START_DATE} ${NEXT_DATE}"
#       
#     fi
     PSTART_DATE=`date "+%Y%m%d%H" --date="${PY}-${PM}-${PD} ${PH}:00:00 ${PINCR} hours"`
  done


  START_DATE=`date "+%Y%m%d%H" --date="${Y}-${M}-${D} ${H}:00:00  ${INCR} hours"`
done

