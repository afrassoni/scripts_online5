'reinit'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/obs/200601/prec_200601.ctl'
'set display color white'
'c'
'set mpdset brmap_mres'
'set grads off'
'set grid off'
#'set lat -35 -15'
#'set lon -65 -45'

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
'color 0 50 5 -kind white->violet->deepskyblue->blue->blue->darkblue->gray'
'd prec'
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

'printim prec_peso_obs.gif'
