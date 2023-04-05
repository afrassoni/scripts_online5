'reinit'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/arqctl/fft01.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/arqctl/fft02.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/arqctl/fft03.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/arqctl/fft04.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/dataout/arqctl/fft05.ctl'



ti=1
tf=5

while(ti<=tf)

'define dif0=sqrt(((w.1(t='ti')-0.2)*(w.1(t='ti')-0.2)))'
'define dif1=sqrt(((w.2(t='ti')-w.1(t='ti'))*(w.2(t='ti')-w.1(t='ti'))))'
'define dif2=sqrt(((w.3(t='ti')-w.2(t='ti'))*(w.3(t='ti')-w.2(t='ti'))))'
'define dif3=sqrt(((w.4(t='ti')-w.3(t='ti'))*(w.4(t='ti')-w.3(t='ti'))))'
'define dif4=sqrt(((w.5(t='ti')-w.4(t='ti'))*(w.5(t='ti')-w.4(t='ti'))))'


'define mdif0=aave(dif0,x=1,x=201,y=1,y=255)'
'define mdif1=aave(dif1,x=1,x=201,y=1,y=255)'
'define mdif2=aave(dif2,x=1,x=201,y=1,y=255)'
'define mdif3=aave(dif3,x=1,x=201,y=1,y=255)'
'define mdif4=aave(dif4,x=1,x=201,y=1,y=255)'


'd mdif0'
  m0=subwrd(result,4)

'd mdif1'
  m1=subwrd(result,4)

'd mdif2'
  m2=subwrd(result,4)

'd mdif3'
  m3=subwrd(result,4)

'd mdif4'
  m4=subwrd(result,4)


  wr=write('norma_pesos_AS.txt', m0'      'm1'     'm2'     'm3'     'm4 , append)

ti=ti+1

endwhile

'quit'
