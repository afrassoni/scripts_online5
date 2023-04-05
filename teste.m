
#
# Definindo titulo
#

set title "South America" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25" offset 0,-3
set ylabel "Rainfall (mm/3h)" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black" front

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "SA2008.eps"
#set terminal png
#set output "SA2008.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first 1 to graph 1, first 1 as 1 front
##set label "1"  at screen 0.07, first 1, first  1 font ",32"

#
# cores das linhas
#

set style line  1 lw 7 lt 1 lc rgb "yellow"
set style line  2 lw 7 lt 1 lc rgb "red"
set style line  3 lw 7 lt 1 lc rgb "green"
set style line  4 lw 7 lt 1 lc rgb "blue"
set style line  5 lw 7 lt 1 lc rgb "cyan"
set style line  6 lw 7 lt 1 lc rgb "purple"
set style line  7 lw 7 lt 1 lc rgb "black"

#
# Posicionando a legenda
#

set key default
set key ins vert
set key 

#
# configurando eixo X
# 

set ytic font ",24"
unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%d\n%b"
set xrange ["2008012712":"2008012809"]
#set xtics "2008012712",21600,"2008012809"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [:]

#
#
#

plot  "SA2008.txt" u 1:2:xtic(1) w l ls 7 title 'Observation',      "SA2008.txt" u 1:3:xtic(1) w l ls 2 title 'EN',      "SA2008.txt" u 1:4:xtic(1) w l ls 3 title 'EnFY'


#plot  "2008.txt" u 1:1:xtic(1) w l ls 1 title 'GR',#      "ets_bias_prec_brams_teste_el..LO.txt" u 1:1:xtic(1) w l ls 2 title 'LO',#      "ets_bias_prec_brams_teste_el..MC.txt" u 1:1:xtic(1) w l ls 3 title 'MC',#      "ets_bias_prec_brams_teste_el..SC.txt" u 1:1:xtic(1) w l ls 4 title 'KF',#      "ets_bias_prec_brams_teste_el..AS.txt" u 1:1:xtic(1) w l ls 5 title 'AS',#      "ets_bias_prec_brams_teste_el..EN.txt" u 1:1:xtic(1) w l ls 6 title 'EN',#      "ets_bias_prec_firefly_teste_el..LO.txt" u 1:1:xtic(1) w l ls 7 title 'FY'

#
# saindo
#

exit


#
# Definindo titulo
#

set title "Southern South America" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25" offset 0,-3
set ylabel "Rainfall (mm/3h)" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black" front

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "southernSA2008.eps"
#set terminal png
#set output "southernSA2008.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first 1 to graph 1, first 1 as 1 front
##set label "1"  at screen 0.07, first 1, first  1 font ",32"

#
# cores das linhas
#

set style line  1 lw 7 lt 1 lc rgb "yellow"
set style line  2 lw 7 lt 1 lc rgb "red"
set style line  3 lw 7 lt 1 lc rgb "green"
set style line  4 lw 7 lt 1 lc rgb "blue"
set style line  5 lw 7 lt 1 lc rgb "cyan"
set style line  6 lw 7 lt 1 lc rgb "purple"
set style line  7 lw 7 lt 1 lc rgb "black"

#
# Posicionando a legenda
#

set key default
set key ins vert
set key 

#
# configurando eixo X
# 

set ytic font ",24"
unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%d\n%b"
set xrange ["2008012712":"2008012809"]
#set xtics "2008012712",21600,"2008012809"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [:]

#
#
#

plot  "southernSA2008.txt" u 1:2:xtic(1) w l ls 7 title 'Observation',      "southernSA2008.txt" u 1:3:xtic(1) w l ls 2 title 'EN',      "southernSA2008.txt" u 1:4:xtic(1) w l ls 3 title 'EnFY'


#plot  "2008.txt" u 1:1:xtic(1) w l ls 1 title 'GR',#      "ets_bias_prec_brams_teste_el..LO.txt" u 1:1:xtic(1) w l ls 2 title 'LO',#      "ets_bias_prec_brams_teste_el..MC.txt" u 1:1:xtic(1) w l ls 3 title 'MC',#      "ets_bias_prec_brams_teste_el..SC.txt" u 1:1:xtic(1) w l ls 4 title 'KF',#      "ets_bias_prec_brams_teste_el..AS.txt" u 1:1:xtic(1) w l ls 5 title 'AS',#      "ets_bias_prec_brams_teste_el..EN.txt" u 1:1:xtic(1) w l ls 6 title 'EN',#      "ets_bias_prec_firefly_teste_el..LO.txt" u 1:1:xtic(1) w l ls 7 title 'FY'

#
# saindo
#

exit


#
# Definindo titulo
#

set title "Northwestern South America" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25" offset 0,-3
set ylabel "Rainfall (mm/3h)" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black" front

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "northwesternSA2008.eps"
#set terminal png
#set output "northwesternSA2008.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first 1 to graph 1, first 1 as 1 front
##set label "1"  at screen 0.07, first 1, first  1 font ",32"

#
# cores das linhas
#

set style line  1 lw 7 lt 1 lc rgb "yellow"
set style line  2 lw 7 lt 1 lc rgb "red"
set style line  3 lw 7 lt 1 lc rgb "green"
set style line  4 lw 7 lt 1 lc rgb "blue"
set style line  5 lw 7 lt 1 lc rgb "cyan"
set style line  6 lw 7 lt 1 lc rgb "purple"
set style line  7 lw 7 lt 1 lc rgb "black"

#
# Posicionando a legenda
#

set key default
set key ins vert
set key 

#
# configurando eixo X
# 

set ytic font ",24"
unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%d\n%b"
set xrange ["2008012712":"2008012809"]
#set xtics "2008012712",21600,"2008012809"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [:]

#
#
#

plot  "northwesternSA2008.txt" u 1:2:xtic(1) w l ls 7 title 'Observation',      "northwesternSA2008.txt" u 1:3:xtic(1) w l ls 2 title 'EN',      "northwesternSA2008.txt" u 1:4:xtic(1) w l ls 3 title 'EnFY'


#plot  "2008.txt" u 1:1:xtic(1) w l ls 1 title 'GR',#      "ets_bias_prec_brams_teste_el..LO.txt" u 1:1:xtic(1) w l ls 2 title 'LO',#      "ets_bias_prec_brams_teste_el..MC.txt" u 1:1:xtic(1) w l ls 3 title 'MC',#      "ets_bias_prec_brams_teste_el..SC.txt" u 1:1:xtic(1) w l ls 4 title 'KF',#      "ets_bias_prec_brams_teste_el..AS.txt" u 1:1:xtic(1) w l ls 5 title 'AS',#      "ets_bias_prec_brams_teste_el..EN.txt" u 1:1:xtic(1) w l ls 6 title 'EN',#      "ets_bias_prec_firefly_teste_el..LO.txt" u 1:1:xtic(1) w l ls 7 title 'FY'

#
# saindo
#

exit


#
# Definindo titulo
#

set title "Northeastern South America" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25" offset 0,-3
set ylabel "Rainfall (mm/3h)" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black" front

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "northeasternSA2008.eps"
#set terminal png
#set output "northeasternSA2008.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first 1 to graph 1, first 1 as 1 front
##set label "1"  at screen 0.07, first 1, first  1 font ",32"

#
# cores das linhas
#

set style line  1 lw 7 lt 1 lc rgb "yellow"
set style line  2 lw 7 lt 1 lc rgb "red"
set style line  3 lw 7 lt 1 lc rgb "green"
set style line  4 lw 7 lt 1 lc rgb "blue"
set style line  5 lw 7 lt 1 lc rgb "cyan"
set style line  6 lw 7 lt 1 lc rgb "purple"
set style line  7 lw 7 lt 1 lc rgb "black"

#
# Posicionando a legenda
#

set key default
set key ins vert
set key 

#
# configurando eixo X
# 

set ytic font ",24"
unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%d\n%b"
set xrange ["2008012712":"2008012809"]
#set xtics "2008012712",21600,"2008012809"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [:]

#
#
#

plot  "northeasternSA2008.txt" u 1:2:xtic(1) w l ls 7 title 'Observation',      "northeasternSA2008.txt" u 1:3:xtic(1) w l ls 2 title 'EN',      "northeasternSA2008.txt" u 1:4:xtic(1) w l ls 3 title 'EnFY'


#plot  "2008.txt" u 1:1:xtic(1) w l ls 1 title 'GR',#      "ets_bias_prec_brams_teste_el..LO.txt" u 1:1:xtic(1) w l ls 2 title 'LO',#      "ets_bias_prec_brams_teste_el..MC.txt" u 1:1:xtic(1) w l ls 3 title 'MC',#      "ets_bias_prec_brams_teste_el..SC.txt" u 1:1:xtic(1) w l ls 4 title 'KF',#      "ets_bias_prec_brams_teste_el..AS.txt" u 1:1:xtic(1) w l ls 5 title 'AS',#      "ets_bias_prec_brams_teste_el..EN.txt" u 1:1:xtic(1) w l ls 6 title 'EN',#      "ets_bias_prec_firefly_teste_el..LO.txt" u 1:1:xtic(1) w l ls 7 title 'FY'

#
# saindo
#

exit


#
# Definindo titulo
#

set title "Central South America" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25" offset 0,-3
set ylabel "Rainfall (mm/3h)" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black" front

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "centralSA2008.eps"
#set terminal png
#set output "centralSA2008.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first 1 to graph 1, first 1 as 1 front
##set label "1"  at screen 0.07, first 1, first  1 font ",32"

#
# cores das linhas
#

set style line  1 lw 7 lt 1 lc rgb "yellow"
set style line  2 lw 7 lt 1 lc rgb "red"
set style line  3 lw 7 lt 1 lc rgb "green"
set style line  4 lw 7 lt 1 lc rgb "blue"
set style line  5 lw 7 lt 1 lc rgb "cyan"
set style line  6 lw 7 lt 1 lc rgb "purple"
set style line  7 lw 7 lt 1 lc rgb "black"

#
# Posicionando a legenda
#

set key default
set key ins vert
set key 

#
# configurando eixo X
# 

set ytic font ",24"
unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%d\n%b"
set xrange ["2008012712":"2008012809"]
#set xtics "2008012712",21600,"2008012809"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [:]

#
#
#

plot  "centralSA2008.txt" u 1:2:xtic(1) w l ls 7 title 'Observation',      "centralSA2008.txt" u 1:3:xtic(1) w l ls 2 title 'EN',      "centralSA2008.txt" u 1:4:xtic(1) w l ls 3 title 'EnFY'


#plot  "2008.txt" u 1:1:xtic(1) w l ls 1 title 'GR',#      "ets_bias_prec_brams_teste_el..LO.txt" u 1:1:xtic(1) w l ls 2 title 'LO',#      "ets_bias_prec_brams_teste_el..MC.txt" u 1:1:xtic(1) w l ls 3 title 'MC',#      "ets_bias_prec_brams_teste_el..SC.txt" u 1:1:xtic(1) w l ls 4 title 'KF',#      "ets_bias_prec_brams_teste_el..AS.txt" u 1:1:xtic(1) w l ls 5 title 'AS',#      "ets_bias_prec_brams_teste_el..EN.txt" u 1:1:xtic(1) w l ls 6 title 'EN',#      "ets_bias_prec_firefly_teste_el..LO.txt" u 1:1:xtic(1) w l ls 7 title 'FY'

#
# saindo
#

exit


#
# Definindo titulo
#

set title "Northern South America and \ tropical Atlantic Ocean" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25" offset 0,-3
set ylabel "Rainfall (mm/3h)" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black" front

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "itcz2008.eps"
#set terminal png
#set output "itcz2008.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first 1 to graph 1, first 1 as 1 front
##set label "1"  at screen 0.07, first 1, first  1 font ",32"

#
# cores das linhas
#

set style line  1 lw 7 lt 1 lc rgb "yellow"
set style line  2 lw 7 lt 1 lc rgb "red"
set style line  3 lw 7 lt 1 lc rgb "green"
set style line  4 lw 7 lt 1 lc rgb "blue"
set style line  5 lw 7 lt 1 lc rgb "cyan"
set style line  6 lw 7 lt 1 lc rgb "purple"
set style line  7 lw 7 lt 1 lc rgb "black"

#
# Posicionando a legenda
#

set key default
set key ins vert
set key 

#
# configurando eixo X
# 

set ytic font ",24"
unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%d\n%b"
set xrange ["2008012712":"2008012809"]
#set xtics "2008012712",21600,"2008012809"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [:]

#
#
#

plot  "itcz2008.txt" u 1:2:xtic(1) w l ls 7 title 'Observation',      "itcz2008.txt" u 1:3:xtic(1) w l ls 2 title 'EN',      "itcz2008.txt" u 1:4:xtic(1) w l ls 3 title 'EnFY'


#plot  "2008.txt" u 1:1:xtic(1) w l ls 1 title 'GR',#      "ets_bias_prec_brams_teste_el..LO.txt" u 1:1:xtic(1) w l ls 2 title 'LO',#      "ets_bias_prec_brams_teste_el..MC.txt" u 1:1:xtic(1) w l ls 3 title 'MC',#      "ets_bias_prec_brams_teste_el..SC.txt" u 1:1:xtic(1) w l ls 4 title 'KF',#      "ets_bias_prec_brams_teste_el..AS.txt" u 1:1:xtic(1) w l ls 5 title 'AS',#      "ets_bias_prec_brams_teste_el..EN.txt" u 1:1:xtic(1) w l ls 6 title 'EN',#      "ets_bias_prec_firefly_teste_el..LO.txt" u 1:1:xtic(1) w l ls 7 title 'FY'

#
# saindo
#

exit

