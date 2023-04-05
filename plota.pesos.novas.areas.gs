'reinit'
rc=gsfallow('on')
'set display color white'
'c'
'set grads off'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/src_v3.1/dataout/weightteste_el.ctl'
'open marcha_prec.ctl'

'q dims'
rx=sublin(result,2)
xi=subwrd(rx,11)
xf=subwrd(rx,13)
ry=sublin(result,3)
yi=subwrd(ry,11)
yf=subwrd(ry,13)


w=write('pesos_marcha_prec.txt','Area  was    wgr    wsc    wmc    wlo')

iarea=1
narea=8
while(iarea<=narea)

   'set x 'xi' 'xf
   'set y 'yi' 'yf

   'define xm=re(mask.2(t=1,z='iarea'),201,LINEAR,-82.875,0.25,249,LINEAR,-49.875,0.25,vt,0.60,0.20)'

   ti  = 1
   tf  = 5
   out = ''
   while(ti<=tf)
      if(ti=1); clt="was"; endif
      if(ti=2); clt="wgr"; endif
      if(ti=3); clt="wsc"; endif
      if(ti=4); clt="wmc"; endif
      if(ti=5); clt="wlo"; endif

      'set t 1'
      'set x 1'
      'set y 1'
      'set gxout print'
      'd aave(maskout('clt',xm-1),x='xi',x='xf',y='yi',y='yf')'
      v=sublin(result,2)
      out = out' 'v
   ti=ti+1

   endwhile

   w=write('pesos_marcha_prec.txt','Area 'iarea' : 'out)

   iarea=iarea+1

endwhile



