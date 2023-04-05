'reinit'
rc=gsfallow('on')
'set display color white'
'c'
'set grads off'
ano=2010
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/ciclo-obs-'ano'01.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/ciclo-mod-ensfis-'ano'01.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/ciclo-mod-ensfisciclofy30-'ano'01.ctl'

tmax=8
i=1
data=''
while (i<=tmax)
   'set t 'i
   'q time'
   rc=subwrd(result,3)
   a=substr(rc,9,4)
   m=substr(rc,6,3)
   m=math_format('%2.2i',cmonth(m))
   d=substr(rc,4,2)
   h=substr(rc,1,2)
   say m
   data=data' 'a m d h
   i=i+1
endwhile

'set t 1 'tmax
'set x 1'
'set y 1'
'set gxout print'
'set prnopts %9.3f ' tmax
'd tloop(aave(precip.1,lon=-82.625,lon=-32.625,lat=-49.875,lat=13.625))'
v1=sublin(result,2)

'd tloop(aave(precip.2,lon=-82.625,lon=-32.625,lat=-49.875,lat=13.625))'
v2=sublin(result,2)

'd tloop(aave(precip.3,lon=-82.625,lon=-32.625,lat=-49.875,lat=13.625))'
v3=sublin(result,2)

w=write_('SA'ano'.txt',data,v1,v2,v3,tmax)

*'set vrange 0 70'
'd tloop(aave(precip.1,lon=-82.625,lon=-32.6,lat=-49.9,lat=-24))'
v1=sublin(result,2)

*'q pos'
'd tloop(aave(precip.2,lon=-82.625,lon=-32.6,lat=-49.9,lat=-24))'
v2=sublin(result,2)

*'q pos'
'd tloop(aave(precip.3,lon=-82.625,lon=-32.6,lat=-49.9,lat=-24))'
v3=sublin(result,2)

w=write_('southernSA'ano'.txt',data,v1,v2,v3,tmax)

*'Draw title Southern South America'
*'printim ../figuras/southernSA'ano'.gif'
*'q pos'
*'c'

*'set vrange 0 70'
'd tloop(aave(precip.1,lon=-82.625,lon=-32.6,lat=-24,lat=-13.5))'
v1=sublin(result,2)
*'q pos'
'd tloop(aave(precip.2,lon=-82.625,lon=-32.6,lat=-24,lat=-13.5))'
v2=sublin(result,2)
*'q pos'
'd tloop(aave(precip.3,lon=-82.625,lon=-32.6,lat=-24,lat=-13.5))'
v3=sublin(result,2)

w=write_('centralSA'ano'.txt',data,v1,v2,v3,tmax)


*'Draw title Central South America'
*'printim ../figuras/centralSA'ano'.gif'
*'q pos'
*'c'

*'set vrange 0 70'
'd tloop(aave(precip.1,lon=-45,lon=-32.6,lat=-13.5,lat=5))'
v1=sublin(result,2)
*'q pos'
'd tloop(aave(precip.2,lon=-45,lon=-32.6,lat=-13.5,lat=5))'
v2=sublin(result,2)
*'q pos'
'd tloop(aave(precip.3,lon=-45,lon=-32.6,lat=-13.5,lat=5))'
v3=sublin(result,2)

w=write_('northeasternSA'ano'.txt',data,v1,v2,v3,tmax)

*'Draw title Northeastern South America'
*'printim ../figuras/northeasternSA'ano'.gif'
*'q pos'
*'c'

*'set vrange 0 70'
'd tloop(aave(precip.1,lon=-82.625,lon=-45,lat=-13.5,lat=5))'
v1=sublin(result,2)
*'q pos'
'd tloop(aave(precip.2,lon=-82.625,lon=-45,lat=-13.5,lat=5))'
v2=sublin(result,2)
*'q pos'
'd tloop(aave(precip.3,lon=-82.625,lon=-45,lat=-13.5,lat=5))'
v3=sublin(result,2)
w=write_('northwesternSA'ano'.txt',data,v1,v2,v3,tmax)


*'Draw title Northwestern South America'
*'printim ../figuras/northwesternSA'ano'.gif'
*'q pos'
*'c'

*'set vrange 0 70'
'd tloop(aave(precip.1,lon=-45,lon=-32.6,lat=5,lat=13.6))'
v1=sublin(result,2)
*'q pos'
'd tloop(aave(precip.2,lon=-45,lon=-32.6,lat=5,lat=13.6))'
v2=sublin(result,2)
*'q pos'
'd tloop(aave(precip.3,lon=-45,lon=-32.6,lat=5,lat=13.6))'
v3=sublin(result,2)

w=write_('itcz'ano'.txt',data,v1,v2,v3,tmax)

*'Draw title Northern South America and \ tropical Atlantic Ocean'
*'printim ../figuras/itcz'ano'.gif'
*'q pos'
*'c'

'd tloop(aave(precip.1,lon=-54,lon=-44,lat=-25,lat=-20))'
v1=sublin(result,2)
*'q pos'
'd tloop(aave(precip.2,lon=-54,lon=-44,lat=-25,lat=-20))'
v2=sublin(result,2)
*'q pos'
'd tloop(aave(precip.3,lon=-54,lon=-44,lat=-25,lat=-20))'
v3=sublin(result,2)

w=write_('saopaulo'ano'.txt',data,v1,v2,v3,tmax)


'quit'

function write_(file,d1,v1,v2,v3,nval)

i=1
while (i<=nval)
   dd=subwrd(d1,i)
   r1=subwrd(v1,i)
   r2=subwrd(v2,i)
   r3=subwrd(v3,i)
   rc = write(file,dd' 'r1' 'r2' 'r3)
i=i+1
endwhile
rc = close(file)
   





