'reinit'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/obs/200602/prec_20060201.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/G3D/novo_entranhamento/bin/20060131/G3D-EN-fft01-apr-EN-A-2006-02-01-120000-g1.ctl'

'define dif=acccon.2(t=1)-prec.1(t=1)'
#  wr=write('tabela_RMS_EN_fft01_AS.txt','Data       &     Bias     &     RMS', append)

'define mdif=aave(dif,x=1,x=201,y=1,y=255)'
'define rms=sqrt(aave(dif*dif,x=1,x=201,y=1,y=255))'
'd mdif'
  m1=subwrd(result,4)
'd rms'
  m2=subwrd(result,4)
  wr=write('tabela_RMS_EN_fft01_AS.txt','20060201   &  '  m1'    &   'm2, append)
'quit'
