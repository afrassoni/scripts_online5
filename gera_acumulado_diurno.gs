*Este scrip eh utilizado para gerar o aculado de cada prazo de previsao

'reinit'
rc=gsfallow('on')

*
* Definicoes
*
* experimentos: ensfis / ensfisciclofy30 / ensfisciclofy60

CLTYPE    = 'EN'
varm      = 'precip'
obs       = 'trmm'
exp       = 'ensfis'
nome      = 'GD-'varm'-'CLTYPE'-'exp'-A'


DirModel='/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/trmm/ANL_'CLTYPE
DirObs  ='/stornext/grupos/catt-brams/ariane.frassoni/dados_obs/'obs'/asul'
DataOut ='/stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/'obs'/ANL_'CLTYPE

StartDate = 2008010112
EndDate   = 2008010112
Incr      = 24
PIncr     = 03
Tmax      = 24
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

say 'open 'DirObs'/'substr(StartDate,1,6)'/'ArqObs'.ctl'
'open 'DirObs'/'substr(StartDate,1,6)'/'ArqObs'.ctl'

'set x 1 'xx
'set y 1 'yy
'set gxout fwrite'
'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/ciclo-mod-'exp'-'substr(StartDate,1,6)'.bin'
*'set fwrite /stornext/grupos/catt-brams/ariane.frassoni/GD/resultados/ciclo-obs-'substr(StartDate,1,6)'.bin'


i=3
while (i <= Tmax)
   di=StartDate
   df=EndDate

   'define so'i'=r*0'
   'define sm'i'=r*0'

   say 'somando'
   while(di<=df)
      
      Pdate=jul2cal(cal2jul(di)+(i/24.0))
      DName =  substr(di,1,8)
      DNameo = substr(di,1,6)
      Ctldate=gdate(Pdate)

      FName =  nome'-'substr(Pdate,1,4)'-'substr(Pdate,5,2)'-'substr(Pdate,7,2)'-'substr(Pdate,9,2)'0000-g1.ctl'

      'set time 'Ctldate
      
      'define so'i'=so'i'+'var
      
      say 'Abrindo modelo ====> open 'DirModel'/'DName'/'FName
      'open 'DirModel'/'DName'/'FName
      
      'define sm'i'=sm'i'+'varm'.2(t=1))'

      'close 2'
      
      di=jul2cal(cal2jul(di)+(Incr/24.0))
   endwhile

*   'd so'i
   'd sm'i
   
   i=i+3
endwhile

'disable fwrite'

'quit'




function geractl()

