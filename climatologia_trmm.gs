'reinit'
'open rmonthly.ctl'
'set display color white'
'c'

'set mpdset brmap mres'
'set grid off' 
'set grads off'
'set xlint 10'
'set ylint 10'
'set xlopts 1 3 0.2'
'set ylopts 1 3 0.2'


rc = gsfallow("on")
rc = panels(3' '4)

v=1
ti=1
while(ti<=12)

'set t 'ti
_vpg.v

'q dims'
rc=sublin(result,5)
dat=subwrd(rc,6)
mon=substr(dat,6,3)
say mon
if(ti=1);mes=Janeiro;endif
if(ti=2);mes=Fevereiro;endif
if(ti=3);mes=Marco;endif
if(ti=4);mes=Abril;endif
if(ti=5);mes=Maio;endif
if(ti=6);mes=Junho;endif
if(ti=7);mes=Julho;endif
if(ti=8);mes=Agosto;endif
if(ti=9);mes=Setembro;endif
if(ti=10);mes=Outubro;endif
if(ti=11);mes=Novembro;endif
if(ti=12);mes=Dezembro;endif

'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs 25 50 100 150 200 250 300 -kind white->lightgreen->green->blue->yellow->orange'
'draw title Precipitacao mensal (mm/mes)  - 'mes
'd r'
'cbarn.gs'

v=v+1
ti=ti+1
endwhile
gxyat - y 2000 -x 3000 media_trmm.png
