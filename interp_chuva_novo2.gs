'reinit'
rc=gsfallow('on')

*
* Definicoes
*

CLTYPE    = 'EN'
varm      = 'precip'
obs       = 'trmm'
nome      = 'GD-avaliacao-e1-'varm'-'CLTYPE'-ensfisciclofy30-A'
*v orig: nome = 'GD-'varm'-'CLTYPE'-ensfis-A'



*v orig: DirModel='/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/ciclo_diurno/ANL_'CLTYPE
DirModel='/stornext/grupos/catt-brams/ariane.frassoni/GD/experimentos/ramspost/ANL_'CLTYPE
DirObs  ='/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/trmm/asul'
DataOut ='/stornext/grupos/catt-brams/ariane.frassoni/GD/experimentos/bin/'obs'/ANL_'CLTYPE
*v orig: DataOut ='/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/'obs'/ANL_'CLTYPE

StartDate = 2008011300
EndDate   = 2008011900
Incr      = 24
PIncr     = 03
Tmax      = 36
*Tmax = tempo maximo de previsao

if(obs='trmm')
   ArqObs = '3B42V7_'substr(StartDate,1,6)
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
      say 'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

      'open 'DirObs'/'substr(StartDate,1,6)'/'ArqObs'.ctl'
      'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

      'define var1=lterp('varm'.2(t=1),'var'.1(t=1))'


*      if(StartDate!=PStartDate)
         NextDate = jul2cal(cal2jul(PStartDate)+(PIncr/24.0))
         Ndate    = gdate(NextDate)

         say NextDate' 'Ndate
         FName    = nome'-'substr(NextDate,1,4)'-'substr(NextDate,5,2)'-'substr(NextDate,7,2)'-'substr(NextDate,9,2)

*         'define var1=varout'
         say 'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

         'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'
          
         'define var2=lterp('varm'.3(t=1),'var'.1(t=1))'
         'define varout=var2-var1'
         'q define'
         say result
         
*      endif
      dout = DataOut'/'substr(StartDate,1,8)
      '!mkdir -p 'dout

      'set gxout fwrite'
      say 'set fwrite 'dout'/'FName'0000-g1.bin'
      'set fwrite 'dout'/'FName'0000-g1.bin'
      'set x 1 'xx
      'set y 1 'yy
      'd varout'
      say result
      'disable fwrite'
      'run allclose.gs'

      PStartDate = jul2cal(cal2jul(PStartDate)+(PIncr/24.0))
   endwhile


   StartDate = jul2cal(cal2jul(StartDate)+(Incr/24.0))
endwhile

'quit'

function geractl()

