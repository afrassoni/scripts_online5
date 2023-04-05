'reinit'

i=3
ii=i-1

while(i<=6)
say ii
say i
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/teste/merge/ANL_EN/GD-EN-ensfisfy30-firefly-A-2010-01-0'ii'-120000-g1.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/teste/merge/ANL_EN/GD-EN-ensfisfy30-firefly-A-2010-01-0'i'-120000-g1.ctl'

'set gxout fwrite'
'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/teste/merge/ANL_EN/GD2-EN-ensfisfy30-firefly-A-2010-01-0'i'-120000-g1.bin'
'd (precip.2(t=1)-precip.1(t=1))'
'disable fwrite'

i=i+1
ii=ii+1
endwhile
'quit'
