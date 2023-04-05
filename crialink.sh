#!/bin/bash


CLS='LO'

dirinp=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/merge/ANL_${CLS}/%y4%m2%d2
dirout=/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/merge/ANL_${CLS}/link

if [ ! -e ${dirout} ]; then
   mkdir -p ${dirout}
fi


mask=GD-precip-${CLS}-ensfis-A-%y4-%m2-%d2-%h20000-g1.bin


DataInicial=2005010112
DataFinal=2005013012
while [ ${DataInicial} -le ${DataFinal} ]; do
   DI=`inctime ${DataInicial} +0d ${dirinp}`
   FileInp=`inctime ${DataInicial} +1d ${DI}/$mask`
   FileOut=`inctime ${DataInicial} +1d ${dirout}/$mask`

   ln -s  ${FileInp} ${FileOut}
   DataInicial=`inctime ${DataInicial} +1d %y4%m2%d2%h2`
done



DataInicial=2006010112
DataFinal=2006013012
while [ ${DataInicial} -le ${DataFinal} ]; do
   DI=`inctime ${DataInicial} +0d ${dirinp}`
   FileInp=`inctime ${DataInicial} +1d ${DI}/$mask`
   Data2=`inctime ${DataInicial} -1y1m %y4%m2%d2%h2`
   FileOut=`inctime ${Data2} +0d ${dirout}/$mask`

   ln -s ${FileInp} ${FileOut}
   DataInicial=`inctime ${DataInicial} +1d %y4%m2%d2%h2`
done



