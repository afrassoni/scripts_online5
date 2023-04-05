'reinit'
'open teste-G3D-pesos-template-A-2006-01-01-120000-g1.ctl'
'open teste-G3D-no-pesos-template-A-2006-01-01-120000-g1.ctl'
'open teste-G3D-cte-template-A-2006-01-01-120000-g1.ctl'

'set display color white'
'c'
'set mpdset brmap mres'
'set grads off'
'/stornext/grupos/catt-brams/ariane.frassoni/scripts/color.gs -levs 0 5 10 15 20 30 40 50 60 70 80 90 100 -kind white->aqua->deepskyblue->blue->mediumblue'
'd acccon.1(t=2)'
'draw title Precipitacao convectiva acumulada 24h - 02/01/2006 \ Usando firefly'
'cbarn.gs'
'printim acccon-pesos.gif'
'c'

'/stornext/grupos/catt-brams/ariane.frassoni/scripts/color.gs -levs 0 5 10 15 20 30 40 50 60 70 80 90 100 -kind white->aqua->deepskyblue->blue->mediumblue'
'd acccon.2(t=2)'
'draw title Precipitacao convectiva acumulada 24h - 02/01/2006 \ Sem pesos'
'cbarn.gs'
'printim acccon-no-pesos.gif'
'c'

'/stornext/grupos/catt-brams/ariane.frassoni/scripts/color.gs -levs 0 5 10 15 20 30 40 50 60 70 80 90 100 -kind white->aqua->deepskyblue->blue->mediumblue'
'd acccon.2(t=2)'
'draw title Precipitacao convectiva acumulada 24h - 02/01/2006 \ Pesos constantes de 0.2'
'cbarn.gs'
'printim acccon-pesos-cte.gif'
'c'

'/stornext/grupos/catt-brams/ariane.frassoni/scripts/color.gs -levs -20 -15 -10 -5 -2 2 5 10 15 20 -kind darkblue->mediumblue->blue->royalblue->deepskyblue->lightskyblue->paleturquoise->white->wheat->orange->darkorange->tomato->orangered->red->crimson->'
'd acccon.1(t=2)-acccon.2(t=2)'
'draw title Diferenca entre chuva com pesos e sem pesos'
'cbarn.gs'
'printim acccon-dif-pesos-nopesos.gif'
'q pos'
'c'


'/stornext/grupos/catt-brams/ariane.frassoni/scripts/color.gs -levs -20 -15 -10 -5 -2 2 5 10 15 20 -kind darkblue->mediumblue->blue->royalblue->deepskyblue->lightskyblue->paleturquoise->white->wheat->orange->darkorange->tomato->orangered->red->crimson->'
'd acccon.1(t=2)-acccon.3(t=2)'
'draw title Diferenca entre chuva com pesos e com pesos constantes'
'cbarn.gs'
'printim acccon-dif-pesos-pesos-cte.gif'
'q pos'
'c'

'/stornext/grupos/catt-brams/ariane.frassoni/scripts/color.gs -levs -20 -15 -10 -5 -2 2 5 10 15 20 -kind darkblue->mediumblue->blue->royalblue->deepskyblue->lightskyblue->paleturquoise->white->wheat->orange->darkorange->tomato->orangered->red->crimson->'
'd acccon.2(t=2)-acccon.3(t=2)'
'draw title Diferenca entre chuva sem pesos e com pesos constantes'
'cbarn.gs'
'printim acccon-dif-nopesos-pesos-cte.gif'
'q pos'
'c'



      

