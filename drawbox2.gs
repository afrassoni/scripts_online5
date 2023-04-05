***************************************************************************************
*	$Id: drawbox.gs,v 1.5 2010/10/26 21:19:19 bguan Exp $
*	Copyright (C) 2010 Bin Guan.
*	Distributed under GNU/GPL.
***************************************************************************************
function drawbox(arg)
*
* Draw an unfilled "box" under any map projection.
*
lon1=subwrd(arg,1)
lon2=subwrd(arg,2)
lat1=subwrd(arg,3)
lat2=subwrd(arg,4)
cor=subwrd(arg,5)
if(lat2='')
usage()
return
endif
if(lon2<lon1)
say 'DRAWBOX Error: <lon2> must be >= <lon1>.'
return
endif
if(lat2<lat1)
say 'DRAWBOX Error: <lat2> must be >= <lat1>.'
return
endif

'query w2xy 'lon1' 'lat1
xlo=subwrd(result,3)
ylo=subwrd(result,6)
'query w2xy 'lon2' 'lat2
xhi=subwrd(result,3)
yhi=subwrd(result,6)
'set line 'cor
'draw recf 'xlo' 'ylo' 'xhi' 'yhi

return
***************************************************************************************
function usage()
*
* Print usage information.
*
say '  Draw an unfilled "box" under any map projection.'
say ''
say '  Usage: drawbox <lon1> <lon2> <lat1> <lat2>'
say '     <lon1>: Beginning longitude.'
say '     <lon2>: Ending longitude. Must be >= <lon1>.'
say '     <lat1>: Beginning latitude.'
say '     <lat2>: Ending latitude. Must be >= <lat1>.'
say ''
say '  Copyright (C) 2010 Bin Guan.'
say '  Distributed under GNU/GPL.'
return
