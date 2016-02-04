###################### Options ###########################################
#set title "gg -> ng Cross Secti"
#set logscale x
#set logscale y
#set format x "%L"
#set format y "10^{%L}"
#set xtics (2,3,4,5,6)
#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)
#set tics scale 2
#set key at 1.0E3,1.0E7 samplen 2
#set xlabel 'Final gluons' offset 0,0
#set ylabel 'Cross Section (fb)' offset 0,0
#set xrange [1:7]
#set yrange [1E-5:2E8]
####################### Definitions ######################################
file1 = 'mh_cp-th23_1100.dat'
file2 = 'mh_cp-th23_1210.dat'
file3 = 'mh_cp-th23_940.dat'
c1 = 'red'			
c2 = 'blue'
c3 = '#006400' # dark green
c4 = 'purple'
c5 = 'orange'
c6 = '#ff33ff'
c7 = 'black'
set style line 1 lt 1 lc rgb c1 lw 5
set style line 2 lt 1 lc rgb c1 lw 5
set style line 3 lt 1 lc rgb c2 lw 5
set style line 4 lt 1 lc rgb c3 lw 5
set style line 5 lt 1 lc rgb c4 lw 5
set style line 6 lt 1 lc rgb c5 lw 5
set style line 7 lt 1 lc rgb c6 lw 5
set style increment user
##########################################################################
set terminal postscript eps enhanced "Times-Roman" color 20
set output "mh_cp-ss23.eps"
set grid
set nokey
#set key out

unset surface
set view map
#set pm3d
set contour base
set cntrparam order 3
set cntrparam bspline
set cntrparam levels discrete 4,9,16,25,36,49,64
set xrange [0.3:0.7]
set yrange [-180:180]
#set xtics ("" 0.3,"0.4" 0.02,"" 0.03,"0.04" 0.04,"" 0.05,"0.06" 0.06,"" 0.07,"0.08" 0.08,"" 0.09,"0.10" 0.1,"" 0.11,"0.12" 0.12,"" 0.13,"0.14" 0.14)
set ytics ("-180" -180,"" -150,"" -120,"-90" -90,"" -60,"" -30,"0" 0,"" 30,"" 60,"90" 90,"" 120,"" 150,"180" 180)

#set label "4" at 0.011, 130
set label "9" at 0.42, 40
set label "16" at 0.45, -15
set label "25" at 0.48, -110
#set label "36" at 0.084,130
#set label "49" at 0.118, 130
#set label "64" at 0.127, -90
set label "{/=26 NH}" at 0.63, 150

set multiplot

set title "{/=24  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260}), {/Symbol n}:{/Symbol n} = 2.5:2.5 ({/Symbol \264}{/=22 10^{/=14 21} POT})}"
set xlabel '{/=24 sin^2{/Symbol q}@_{/=16 23}^{input}' offset 0,-0.5
set ylabel '{/=24 {/Symbol d}@_{/=16 MNS}^{input}'
#################### plot ##########################################
splot file1 u 1:2:3 notitle w l
###########################################################################

set style line 2 lt 4 lc rgb c1 lw 3
set style line 3 lt 4 lc rgb c2 lw 3
set style line 4 lt 4 lc rgb c3 lw 3
set style line 5 lt 4 lc rgb c4 lw 3
set style line 6 lt 4 lc rgb c5 lw 3
set style line 7 lt 4 lc rgb c6 lw 3
set style line 8 lt 4 lc rgb c7 lw 3
set style increment user
#################### plot ##########################################
splot file2 u 1:2:3 notitle w l
###########################################################################

set style line 1 lt 1 lc rgb c1 lw 2
set style line 2 lt 1 lc rgb c1 lw 2
set style line 3 lt 1 lc rgb c2 lw 2
set style line 4 lt 1 lc rgb c3 lw 2
set style line 5 lt 1 lc rgb c4 lw 2
set style line 6 lt 1 lc rgb c5 lw 2
set style line 7 lt 1 lc rgb c6 lw 2
set style increment user
#################### plot ##########################################
splot file3 u 1:2:3 notitle w l
###########################################################################

set nomultiplot
reset