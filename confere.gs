'reinit'
'open /stornext/grupos/catt-brams/ariane.frassoni/dados_obs/trmm/asul/200601/3B42V7_200601.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/trmm/ANL_AS/20060101/GD-precip-AS-ensfis-A-2006-01-01-150000-g1.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/trmm/ANL_GR/20060101/GD-precip-GR-ensfis-A-2006-01-01-150000-g1.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/trmm/ANL_LO/20060101/GD-precip-LO-ensfis-A-2006-01-01-150000-g1.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/trmm/ANL_MC/20060101/GD-precip-MC-ensfis-A-2006-01-01-150000-g1.ctl'
'open /stornext/grupos/catt-brams/ariane.frassoni/GD/bin/ciclo_diurno/trmm/ANL_SC/20060101/GD-precip-SC-ensfis-A-2006-01-01-150000-g1.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/src_v3.1/weightensfisciclo15.ctl'
'open /scratchin/grupos/catt-brams/home/ariane.frassoni/Firefly/src_v3.1/NewPrecensfisciclo15.ctl'
'set display color white'
'c'
'set mpdset brmap mres'
'define mod=precip.2(t=1)*0.0'

i=2
f=6
while(i<=f)
if (i=2);w=was; endif
if (i=3);w=wgr; endif
if (i=4);w=wlo; endif
if (i=5);w=wmc; endif
if (i=6);w=wsc; endif

'define mod=mod+precip.'i'(t=1)*'w'.7(t=1)'

i=i+1
endwhile

'set gxout grfill'
'color.gs -levs -30 -25 -20 -15 -10 -5 -2.5 -0.5 0.5 2.5 5 10 15 20 25 30 -kind red->gold->white->lightblue->blue'
'set time 15z01jan2006'
'define dif=r-mod'
'd dif'
'cbar'
'q pos'

'set gxout grfill'
'color.gs -levs -30 -25 -20 -15 -10 -5 -2.5 -0.5 0.5 2.5 5 10 15 20 25 30 -kind red->gold->white->lightblue->blue'
'set time 15z01jan2006'
'define dif=r-precip.8(t=1)'
'd dif'
'cbar'
'q pos'

'quit'
