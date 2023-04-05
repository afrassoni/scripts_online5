*Este scrip eh utilizado para gerar o aculado de cada prazo de previsao

'reinit'
rc=gsfallow('on')

*
* Definicoes
*

CLTYPE    = 'EN'
varm      = 'precip'
obs       = 'trmm'
nome      = 'GD-'varm'-'CLTYPE'-ensfisciclofy30-A'


DirModel='/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/ciclo_diurno/ANL_'CLTYPE
DirObs  ='/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/trmm/asul'
DataOut ='/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/'obs'/ANL_'CLTYPE

StartDate = 2006010115
EndDate   = 2006013115
Incr      = 24
PIncr     = 24
Tmax      = 24
*Tmax = tempo maximo de previsao

if(obs='trmm')
   ArqObs = '3B42V7_200601'
   var    = 'r'
   xx     = '201'
   yy     = '255'
   xi     = '-82.625'
   yi     = '-49.875'
endif

if(obs='merge')
   ArqObs = 'prec_'
   var    = 'prec'
   xx     = '201'
   yy     = '255'
   xi     = '-82.6250'
   yi     = '-49.8750'
endif

  'open 'DirObs'/'substr(StartDate,1,6)'/'ArqObs'.ctl'
*  'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

  'define sumobs='var'.1*0.0'
*  'define summod='varm'.2*0.0'


while (StartDate <= EndDate)
   
   PStartDate = StartDate
   IncMax     = Tmax - PIncr
   PEndDate   = jul2cal(cal2jul(PStartDate)+(IncMax/24.0))
   say PEndDate' >>> 'IncMax

   
   while(PStartDate <= PEndDate)

       Sdate=gdate(StartDate)
       say StartDate
       
       Pdate=gdate(PStartDate)

      FName = nome'-'substr(PStartDate,1,4)'-'substr(PStartDate,5,2)'-'substr(PStartDate,7,2)'-'substr(PStartDate,9,2)

      say 'open 'DirObs'/'substr(StartDate,1,6)'/'ArqObs'.ctl'
      'open 'DirObs'/'substr(StartDate,1,6)'/'ArqObs'.ctl'


*      say 'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'
*      'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

      say 'define sumobs=sumobs+'var'.1(t=1)'
      'define sumobs=sumobs+'var'.1(t=1)'
      '
      'd sumobs'
*      'define summod=summod+'varm'.1(t=1)'

      NextDate = jul2cal(cal2jul(PStartDate)+(PIncr/24.0))
      Ndate    = gdate(NextDate)

      say NextDate' 'Ndate
      FName    = nome'-'substr(NextDate,1,4)'-'substr(NextDate,5,2)'-'substr(NextDate,7,2)'-'substr(NextDate,9,2)

      say 'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

*      'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'
          
*         'define var2=lterp('varm'.3(t=1),'var'.1(t=1))'
*         'define varout=var2-var1'
         'q define'
         say result
         
*      endif
      dout = DataOut'/'substr(StartDate,1,8)
*      '!mkdir -p 'dout

*      'set gxout fwrite'
*      say 'set fwrite 'dout'/'FName'0000-g1.bin'
*      'set fwrite 'dout'/'FName'0000-g1.bin'
*      'set x 1 'xx
*      'set y 1 'yy
*      'd varout'
*      say result
*      'disable fwrite'
*      'run allclose.gs'

      PStartDate = jul2cal(cal2jul(PStartDate)+(PIncr/24.0))
   endwhile

'close 1'
   StartDate = jul2cal(cal2jul(StartDate)+(Incr/24.0))
endwhile

'q pos'
'quit'

function geractl()


