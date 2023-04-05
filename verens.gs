'reinit'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060130/G3D-EN-fft01-apr-MC-A-2006-01-31-120000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060130/G3D-EN-fft01-apr-LO-A-2006-01-31-120000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060130/G3D-EN-fft01-apr-KF-A-2006-01-31-120000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060130/G3D-EN-fft01-apr-AS-A-2006-01-31-120000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060130/G3D-EN-fft01-apr-GR-A-2006-01-31-120000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060130/G3D-EN-fft01-apr-EN-A-2006-01-31-120000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/obs/200601/prec_20060131.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/pesos/20060130/G3D-EN-fft01-w-A-2006-01-31-120000-g1.ctl'

'set display color white'
'c'
'set mpdset brmap mres'
'set grads off'
'color.gs -2 2 0.5 -kind red->white->blue' 


'define sclos=(aprmc.1*weightMC.8)+(aprw.2*weightW.8)+(aprst.3*weightST.8)+(apras.4*weightAS.8)+(aprgr.5*weightGR.8)'
'define difen=sclos-acccon.6'
'd difen'
'cbarn.gs'
'draw title Diferenca entre Soma dos fechamentos e Ensemble \ 2006-01-31'
'printim dif-fft01-2006-01-31-120000-g1.gif'

'define mobs=aave(prec.7,x=1,x=201,y=1,y=255)'
'define msclos=aave(sclos,x=1,x=201,y=1,y=255)'
'define mens=aave(acccon.6,x=1,x=201,y=1,y=255)'
'define mdif=aave(difen,x=1,x=201,y=1,y=255)'
'define porc=((msclos*100)/mens)-100'

'd mobs'
m0=subwrd(result,4)

'd msclos'
m1=subwrd(result,4)

'd mens'
m2=subwrd(result,4)

'd mdif'
m3=subwrd(result,4)

'd porc'
m4=subwrd(result,4)

wr=write('confere_ens_fft01_AS.txt','20060131   'm0'     'm1'     'm2'     'm3'    'm4, append)

'quit'
