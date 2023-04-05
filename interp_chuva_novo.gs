'reinit'
rc=gsfallow('on')

*
* Definicoes
*
* Alteracoes necessarias: 1) data, 2) diretorios
CLTYPE    = 'EN'
varm      = 'precip'
obs       = 'merge'
nome      = 'GD-'varm'-'CLTYPE'-ensfis-A'


DirModel='/stornext/grupos/catt-brams/ariane.frassoni/GD/ramspost/novo_entranhamento/ANL_'CLTYPE
DirObs  ='/stornext/grupos/catt-brams/ariane.frassoni/dados_obs'
DataOut ='/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/novo_entranhamento/'obs'/ANL_'CLTYPE

StartDate = 2008010100
EndDate   = 2008010100
Incr      = 24
PIncr     = 24
Tmax      = 120

if(obs='trmm')
   ArqObs = '3B42V6.'
   var    = 'r'
   xx     = '198'
   yy     = '249'
   xi     = '-83.125'
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

   while(PStartDate <= PEndDate)
      
      FName = nome'-'substr(PStartDate,1,4)'-'substr(PStartDate,5,2)'-'substr(PStartDate,7,2)'-'substr(PStartDate,9,2)
      say 'open 'DirObs'/'obs'/'substr(StartDate,1,6)'/'ArqObs substr(StartDate,1,6)'.ctl'
      say 'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

      'open 'DirObs'/'obs'/'substr(StartDate,1,6)'/'ArqObs substr(StartDate,1,6)'.ctl'
      'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

      say 'define varout=lterp('varm'.2(t=1),'var'.1)'
*      'define varout=lterp('varm'.2(t=1),'var'.1)'
      'define var1=lterp('varm'.2(t=1),'var'.1)'


*      if(StartDate!=PStartDate)
         NextDate = jul2cal(cal2jul(PStartDate)+(PIncr/24.0))
         say NextDate
         FName    = nome'-'substr(NextDate,1,4)'-'substr(NextDate,5,2)'-'substr(NextDate,7,2)'-'substr(NextDate,9,2)

*         'define var1=varout'
         say 'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'

         'open 'DirModel'/'substr(StartDate,1,8)'/'FName'0000-g1.ctl'
          
         'define var2=lterp('varm'.3(t=1),'var'.1)'
         'define varout=var2-var1'

*      endif
      dout = DataOut'/'substr(StartDate,1,8)
      '!mkdir -p 'dout

      'set gxout fwrite'
say      'set fwrite 'dout'/'FName'0000-g1.bin'
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

