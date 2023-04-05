#! /bin/bash



#
# Configuracoes da plotagem
#

ano=2010;

title[1]="South America";
title[2]="Southern South America";
title[3]="Northwestern South America";
title[4]="Northeastern South America";
title[5]="Central South America";
title[6]="Northern South America and \ tropical Atlantic Ocean";
title[7]="Sao Paulo";



nome[1]="SA";
nome[2]="southernSA";
nome[3]="northwesternSA";
nome[4]="northeasternSA";
nome[5]="centralSA";
nome[6]="itcz";
nome[7]="saopaulo";


#
# definicoes ! Nao Mexer
#
linepos=1

keypos[1]="right top"
keypos[2]="right top"
keypos[3]="right top"
keypos[4]="right top"
keypos[5]="right top"
keypos[6]="right top"
keypos[7]="right top"

int[1]="-5:15"
int[2]="-5:5"
int[3]="-15:25"
int[4]="-10:40"
int[5]="-10:20"
int[6]="-10:20"
int[7]="-30:50"



#
# Iniciando gnuplot
#

i=1
while [ ${i} -le 7 ];do

FNameOut="${nome[${i}]}${ano}"

datainicial=`head -n 1 ${FNameOut}.txt | awk '{print $1}'`
datafinal=`tail -n 1 ${FNameOut}.txt | awk '{print $1}'`


gnuplot << EOF

#
# Definindo titulo
#

set title "${title[$i]}" font ",25"

#
# Identificando os Eixos
#

set xlabel "Time" font ",25"
set ylabel "Bias (mm)${varname[${ivar}]}" font ",25"

#
# adicionando background
#

#set object 2 rect from graph 0, graph 0 to graph 1, graph 1 behind
#set object 2 rect fc rgb "#FFF9D9" fillstyle solid 1.0
#set style fill pattern 2 bo 1

#
# adicionando grade
#

set grid lc rgb "black"

#
# definindo o arquivo de saida
#
set encoding utf8
set term postscript enhanced color
set output "${FNameOut}.eps"
#set terminal png
#set output "${FNameOut}.png"

#
# desenhando linha horizontal em 1
#

#set style line 1 lt 2 lc rgb "black" lw 1
#set style arrow 1 nohead ls 1
#set arrow 1 from graph 0,first ${linepos} to graph 1, first ${linepos} as 1 font
##set label "1"  at screen 0.07, first ${linepos}, first  ${linepos} font ",32"

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
set key ${keypos[${ivar}]}

#
# configurando eixo X
# 

set ytic font ",24"
#unset xtics

set xdata time
set timefmt "%Y%m%d%H"
set format x "%HZ"
set xrange ["${datainicial}":"${datafinal}"]
set xtics "${datainicial}",10800,"${datafinal}"

#set xtics nomirror rotate by -90 scale 0 font ",24"

#set yrange [${min[${ivar}]}:${max[${ivar}]}]
set yrange [${int[${i}]}]

#
#
#

plot  "${FNameOut}.txt" u 1:(\$3-\$2) w l ls 2 title 'EN',\
      "${FNameOut}.txt" u 1:(\$4-\$2) w l ls 3 title 'EnFY'




#
# saindo
#

exit

EOF

convert -rotate 90 -density 100 ${FNameOut}.eps -flatten ${FNameOut}.png

   i=$((i+1))
done

