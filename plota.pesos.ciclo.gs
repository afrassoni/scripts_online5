'reinit'
rc=gsfallow('on')
'set display color white'
'c'
'set grads off'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/src_v3.1/dataout/weightensfisciclo.ctl'



ti=1
tf=8

while(ti<=tf)

w=write('pesos'ti'.txt','&  was  &  wgr &   wsc  &  wmc  &  wlo')

vari=1
varf=5

while(vari<=varf)
if(vari=1); clt="was"; endif
if(vari=2); clt="wgr"; endif
if(vari=3); clt="wsc"; endif
if(vari=4); clt="wmc"; endif
if(vari=5); clt="wlo"; endif

'set t 'ti
'set x 1'
'set y 1'
'set gxout print'
'd aave('clt'(t='ti'),lon=-82.625,lon=-32.625,lat=-49.875,lat=13.625)'
v1.vari=sublin(result,2)

'd aave('clt'(t='ti'),lon=-82.625,lon=-32.6,lat=-49.9,lat=-24)'
v2.vari=sublin(result,2)

'd aave('clt'(t='ti'),lon=-82.625,lon=-32.6,lat=-24,lat=-13.5)'
v3.vari=sublin(result,2)

'd aave('clt'(t='ti'),lon=-45,lon=-32.6,lat=-13.5,lat=5)'
v4.vari=sublin(result,2)

'd aave('clt'(t='ti'),lon=-82.625,lon=-45,lat=-13.5,lat=5)'
v5.vari=sublin(result,2)

'd aave('clt'(t='ti'),lon=-45,lon=-32.6,lat=5,lat=13.6)'
v6.vari=sublin(result,2)

'd aave('clt'(t='ti'),lon=-54,lon=-44,lat=-25,lat=-20)'
v7.vari=sublin(result,2)


vari=vari+1


endwhile
w=write('pesos'ti'.txt','América do Sul & 'v1.1' & 'v1.2' & 'v1.3' & 'v1.4' & 'v1.5)
w=write('pesos'ti'.txt','Sul da AS & 'v2.1' & 'v2.2' & 'v2.3' & 'v2.4' & 'v2.5)
w=write('pesos'ti'.txt','Central AS & 'v3.1' &'v3.2' & 'v3.3' & 'v3.4' & 'v3.5)
w=write('pesos'ti'.txt','Nordeste AS & 'v4.1' & 'v4.2' & 'v4.3' & 'v4.4' & 'v4.5)
w=write('pesos'ti'.txt','Noroeste AS & 'v5.1' & 'v5.2' & 'v5.3' & 'v5.4' & 'v5.5)
w=write('pesos'ti'.txt','Atlântico & 'v6.1' & 'v6.2' & 'v6.3' & 'v6.4' & 'v6.5)
w=write('pesos'ti'.txt','São Paulo & 'v7.1' & 'v7.2' & 'v7.3' & 'v7.4' & 'v7.5)

ti=ti+1

endwhile


'quit'
