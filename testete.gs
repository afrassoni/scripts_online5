'reinit'
'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/novo_entranhamento/ANL_EN/20060101/GD-precip-EN-ensfis-A-2006-01-02-120000-g1.ctl'
'set gxout fwrite'
'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/merge/ANL_EN/20060101/GD-precip-EN-ensfis-A-2006-01-02-120000-g1.bin'
'd lterp(precip.2(t=1),prec.1)'
'disable fwrite'
'quit'
