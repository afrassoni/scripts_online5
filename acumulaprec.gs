'reinit'
*'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/merge/ANL_EN/24h/

'define soma=sum(prec,time=02jan2006,time=31jan2006)'
'set gxout fwrite'
'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/prec_200601.bin'
'set x 1 201'
'set y 1 255'
'd soma'
'disable fwrite'
'quit'
