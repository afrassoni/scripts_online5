dirinp=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/%y4%m2
dirout=/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/link

if [ ! -e ${dirout} ]; then
   mkdir -p ${dirout}
fi


mask=prec_%y4%m2%d2.bin


DataInicial=2005010112
DataFinal=2005013112
while [ ${DataInicial} -le ${DataFinal} ]; do
   FileInp=`inctime ${DataInicial} +0d ${dirinp}/$mask`
   FileOut=`inctime ${DataInicial} +0d ${dirout}/$mask`

   ln -s ${FileInp} ${FileOut}
   DataInicial=`inctime ${DataInicial} +1d %y4%m2%d2%h2`
done



DataInicial=2006010212
DataFinal=2006013112
while [ ${DataInicial} -le ${DataFinal} ]; do
   FileInp=`inctime ${DataInicial} +0d ${dirinp}/$mask`
   Data2=`inctime ${DataInicial} -1y1m1d %y4%m2%d2%h2`
   FileOut=`inctime ${Data2} +0d ${dirout}/$mask`

   ln -s ${FileInp} ${FileOut}
   DataInicial=`inctime ${DataInicial} +1d %y4%m2%d2%h2`
done


