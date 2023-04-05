'reinit'
ano=2008
'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/trmm/global/'ano'01/3B42_V7.ctl'

'set lat -49.875 13.625'
'set lon -82.625 -32.625'
'q dims'

xx=sublin(result,2)
xi=subwrd(xx,11)
xf=subwrd(xx,13)
yy=sublin(result,3)
yi=subwrd(yy,11)
yf=subwrd(yy,13)

say xi' 'xf' 'yi' 'yf 

ti=1
tf=248
while(ti<=tf)
'set t 'ti
'q dims'
rc=sublin(result,5)
wd=subwrd(rc,6)
mes=01
dia=substr(wd,4,2)
hor=substr(wd,1,2)

'set x 'xi' 'xf
'set y 'yi' 'yf
'set gxout fwrite'
'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/trmm/asul/'ano mes'/3B42V7_'ano mes dia hor'.bin'
'd r*3'
'disable fwrite'
ti=ti+1
endwhile

'quit'
