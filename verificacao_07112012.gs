'reinit'

'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-AS-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-SC-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-GR-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-MC-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-LO-ensfis-A-2006-01-template.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/Firefly/GD/novo_entranhamento/merge/24h/GD-EN-ensfis-A-2006-01-template.ctl'

'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/merge/200601/prec_200601.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/datain/comparacao/NewPrec.ctl'



'set t 1'
'q dims'
rc=sublin(result,5)
dat=subwrd(rc,6)
year=substr(dat,9,4)
mon=substr(dat,6,3)
day=substr(dat,4,2)

'set t last'
'q dims'
rc=sublin(result,5)
dat=subwrd(rc,6)
yearf=substr(dat,9,4)
monf=substr(dat,6,3)
dayf=substr(dat,4,2)

'define medAS=ave(acccon.1,t=1,t=30)'
'define medSC=ave(acccon.2,t=1,t=30)'
'define medGR=ave(acccon.3,t=1,t=30)'
'define medMC=ave(acccon.4,t=1,t=30)'
'define medLO=ave(acccon.5,t=1,t=30)'
'define medEN=ave(acccon.6,t=1,t=30)'
'define medOB=ave(prec.7,time='day mon year',time='dayf monf yearf')'
'define medFY=ave(prec.8,t=1,t=30)'

'define mSP=acccon.1*0'
'd mSP'

ti=1
tf=2
while(ti<=tf)
  i=1
  while(i<=5)
    'define mSP=mSP+acccon.'i'(t='ti')'
  i=i+1
  endwhile
ti=ti+1
endwhile
say tf
'define medSP=(mSP/'tf')/5)'
'd medSP'

'set display color white'
'c'
'set mpdset brmap_mres'
'set grads off'
'set grid off'

rc = gsfallow("on")
rc = panels(3' '4)

_vpg.1
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medAS-medOB'
'cbarn'
'draw title a) G3D-OBS'

_vpg.2
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medSC-medOB'
'cbarn'
'draw title b) SC-OBS'

_vpg.3
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medGR-medOB'
'cbarn'
'draw title c) GR-OBS'

_vpg.4
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medMC-medOB'
'cbarn'
'draw title d) MC-OBS'

_vpg.5
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medLO-medOB'
'cbarn'
'draw title e) LO-OBS'

_vpg.6
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medEN-medOB'
'cbarn'
'draw title f) EN-OBS'

_vpg.7
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medAS'
'cbarn'
'draw title g) FY-G3D'

_vpg.8
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medSC'
'cbarn'
'draw title h) FY-SC'

_vpg.9
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medGR'
'cbarn'
'draw title i) FY-GR'

_vpg.10
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medMC'
'cbarn'
'draw title j) FY-MC'

_vpg.11
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medLO'
'cbarn'
'draw title k) FY-LO'

_vpg.12
'set gxout grfill'
'set grads off'
'set mpdset hires'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medEN'
'cbarn'
'draw title l) FY-EN'

'printim diferencas24h.gif'

'q pos'

'c'

'reset'

rc = gsfallow("on")
rc = panels(2' '2)

_vpg.1
'set gxout grfill'
'set grads off'
'set mpdset hires'
'set xlint 10'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medFY-medOB'
'cbarn'
'draw title a) FY-OBS'

_vpg.2
'set gxout grfill'
'set grads off'
'set mpdset hires'
'set xlint 10'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medEN-medOB'
'cbarn'
'draw title b) EN-OBS'

_vpg.3
'set gxout grfill'
'set grads off'
'set mpdset hires'
'set xlint 10'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medAS-medOB'
'cbarn'
'draw title c) G3D-OBS'

_vpg.4
'set gxout grfill'
'set grads off'
'set mpdset hires'
'set xlint 10'
'/scratchin/grupos/catt-brams/home/ariane.frassoni/scripts/color.gs -levs -40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40 -kind red->orange->white->skyblue->blue'
'd medSP-medOB'
'cbarn'
'draw title c) MS-OBS'


#baropt = ' 1 10 1.6 1.8 -line on -direction horizontal -edge circle'
#baropt = ' 1 10 1.6 1.8 -line on -edge circle'
levs   = '-40 -35 -30 -25 -20 -15 -10 -5 -1 1 5 10 15 20 25 30 35 40'
cor    = 'red->orange->white->skyblue->blue'

'set vpage off'
'color -levs 'levs' -kind 'cor
#' -xcbar  'baropt

'printim vies24h.gif'


