'reinit'
'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/comparacao/NewPrec.ctl'

'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-AS-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-SC-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-GR-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-MC-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-LO-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-EN-ensfis-A-2006-01-template.ctl'


'set display color white'
'c'
'set mpdset brmap_mres'
'set grads off'
'set grid off'
'set lat -35 -15'
'set lon -65 -45'

rc = gsfallow("on")
rc = panels(3' '4)

ti=1
tf=12
v=1
while(ti<=tf)

'set t 'ti' 'tf 
_vpg.v
'set t 'ti
'set gxout grfill'
'set grads off'
'set mpdset hires'
'define medAS=ave(acccon.3,t=1,t=30)'
'define medSC=ave(acccon.4,t=1,t=30)'
'define medGR=ave(acccon.5,t=1,t=30)'
'define medMC=ave(acccon.6,t=1,t=30)'
'define medLO=ave(acccon.7,t=1,t=30)'
'define medEN=ave(acccon.8,t=1,t=30)'

'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue

'd prec-medAS'
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
'printim prec_peso_'peso'_sul1.gif'

'c'

ti=13
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

'printim prec_peso_'peso'_sul2.gif'

'c'

ti=26
tf=38
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

'printim prec_peso_'peso'_sul3.gif'
