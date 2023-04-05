#! /bin/sh -x

./move_file.sh    # move os arquivos do /scratchou pra o /stornext

./ramspost.ksh    # pos-processa os arquivos ANL para o formato do GrADS a partir do /stornext. Salva os arquivos também no /stornext

./lterp.ksh       # faz a homogeinizacao das grades com o lterp. Busca os arquivos no /stornext

./rms.ksh         # calcula os indices estatisticos 

mv *.txt /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/resultados
rm gera.area.gs

./copia.ksh       # copia os arquivos das saidas do GrADS para a pasta YYYYMM

