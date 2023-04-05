'reinit'
'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_20060114.ctl'
'set display color white'
'c'
'set mpdset brmap mres'

********************

xmax=201
ymax=255
xbox=60
ybox=50

********************
'set clab off'
'set ccolor 0'
'd prec'

x=1

while (x<=xmax)
   if (x+xbox > xmax)
      break
   endif
   y=1
   while(y<=ymax)
      if (y+ybox > ymax)
         break
      endif
      
      'q gr2xy 'x' 'y
      x1=subwrd(result,3)
      y1=subwrd(result,6)

      'q gr2xy 'x+xbox' 'y+ybox
      x2=subwrd(result,3)
      y2=subwrd(result,6)

      'draw rec 'x1' 'y1' 'x2' 'y2
      y=y+ybox
   endwhile
   x=x+xbox
endwhile

'set ccolor 1'
'draw map'
'q pos'
'quit'

