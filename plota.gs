'reinit'
'open /stornext/grupos/catt-brams/ariane.frassoni/G3D/ramspost/novo_entranhamento/aval_hora/20060101/G3D-EN-cte-apr-EN-template-A-2006-01-01-120000-g1.ctl'
'set display color white'
'c'
'draw title chuva'
rc = gsfallow("on")
rc = panels(3' '4)

cor='redblue'
baropt=' -line on -direction horizontal -edge circle'

ti=1
tf=12
while (ti<=tf)
'set t 'ti 'last' 
'q dims'
rc=sublin(result,5)
x=subwrd(rc,11)
y=subwrd(rc,13)
v=1
while (x<=y)

 _vpg.v
'set t 'x
'set gxout grfill'
'set grads off'
'set mpdset hires'
'color -levs 0 10 20 30 70 80 90 100 -kind 'cor
'd acccon'
'set gxout contour'
'set clab off'
'set clevs 20'
'set ccolor 1'
'set cstyle 1'
'set cthick 5'
'd acccon'
'color -levs 0 10 20 30 70 80 90 100 -kind 'cor' -cbarn  'baropt


_vpg.1
'set t 1'
'd acccon'
_vpg.2
'set t 2'
'd acccon'

