'reinit'
peso=cte
obs=trmm
dadoobs=3B42V6.200601.ctl
var=r
'open /stornext/grupos/catt-brams/ariane.frassoni/G3D/Firefly/novo_entranhamento/aval_hora/bin/'obs'/20060101/G3D-EN-'peso'-apr-EN-template-A-2006-01-01-g1.ctl'
'set display color white'
'c'
'set mpdset brmap_mres'
'set grads off'
'set grid off'
'set lat -35 -15'
'set lon -65 -45'

rc = gsfallow("on")
rc = panels(3' '4)

ti=2
tf=13
v=1
while(ti<=tf)

'set t 'ti' 'tf 
_vpg.v
'set t 'ti
'set gxout grfill'
'set grads off'
'set mpdset hires'
'color 0 50 5 -kind white->violet->deepskyblue->blue->blue->darkblue->gray'
'd acccon'
'cbarn'
'q dims'
rc=sublin(result,5)
data=subwrd(rc,6)
hor=substr(data,1,2)
dia=substr(data,4,2)
mes=substr(data,6,3)
ano=substr(data,9,4)
'draw title 'mes'/'dia'/'ano' - 'hor'UTC'
v=v+1
ti=ti+1
endwhile
'printim prec_peso_'peso'_'obs'_sul1.gif'
'q pos'
'c'

ti=14
tf=25
v=1
while(ti<=tf)

'set t 'ti' 'tf 
_vpg.v
'set t 'ti
'set gxout grfill'
'set grads off'
'set mpdset hires'
'color 0 50 5 -kind white->violet->deepskyblue->blue->blue->darkblue->gray'
'd acccon'
'cbarn'
'q dims'
rc=sublin(result,5)
data=subwrd(rc,6)
hor=substr(data,1,2)
dia=substr(data,4,2)
mes=substr(data,6,3)
ano=substr(data,9,4)
'draw title 'mes'/'dia'/'ano' - 'hor'UTC'
v=v+1
ti=ti+1
endwhile

'printim prec_peso_'peso'_'obs'_sul2.gif'
'c'

'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/'dadoobs

'set vpage off'
'set time 12Z02jan2006' 
'q dims'
rc=sublin(result,5)
data=subwrd(rc,6)
hor=substr(data,1,2)
dia=substr(data,4,2)
mes=substr(data,6,3)
ano=substr(data,9,4)
ti=subwrd(rc,9)
say ti
'set gxout grfill'
'set grads off'
'set mpdset hires'
'color -50 50 10 -kind red->white->blue'
'd acccon.1(t='ti')-'var'.2(t='ti')'
'cbarn'
'q dims'
'draw title Vies 'mes'/'dia'/'ano' - 'hor'UTC'
'printim vies_'peso'_'obs'.gif'


