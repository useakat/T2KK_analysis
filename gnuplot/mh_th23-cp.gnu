####################### Definitions ######################################
file1 = 'mh_cp-th23_1_1_1100.dat'
file2 = 'mh_cp-th23_1_1_1210.dat'
file3 = 'mh_cp-th23_1_1_940.dat'
c1 = 'red'			
c2 = 'blue'
c3 = '#006400' # dark green
c4 = 'purple'
c5 = 'orange'
c6 = '#ff33ff'
c7 = 'black'
#########################################################################
unset surface
set view 180,90
set contour base
set cntrparam order 3
set cntrparam bspline
set cntrparam levels discrete 4,9,16,25,36,49,64

set table "file1.tab"
splot file1 u 1:2:3 notitle w l
set table "file2.tab"
splot file2 u 1:2:3 notitle w l
set table "file3.tab"
splot file3 u 1:2:3 notitle w l
unset table

set terminal postscript eps enhanced "Times-Roman" color 20
set output "mh_ss23-cp.eps"
set grid
set nokey
#set key out

set lmargin 8.5

xdata=2
ydata=1
set yrange [0.3:0.7]
set xrange [-180:180]
#set xtics ("" 0.3,"0.4" 0.02,"" 0.03,"0.04" 0.04,"" 0.05,"0.06" 0.06,"" 0.07,"0.08" 0.08,"" 0.09,"0.10" 0.1,"" 0.11,"0.12" 0.12,"" 0.13,"0.14" 0.14)
#set xtics ("-180" -180,"" -150,"" -120,"-90" -90,"" -60,"" -30,"0" 0,"" 30,"" 60,"90" 90,"" 120,"" 150,"180" 180)

#set label "4" at 0.011, 130
set label "9" at 0,0.37
set label "16" at -20, 0.45
set label "25" at -110, 0.38
set label "36" at -110,0.53
set label "49" at -110,0.63
#set label "64" at 0.127, -90
set label "{/=26 NH}" at 70,0.67

set title "{/=24  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260}), {/Symbol n}:{/Symbol n} = 2.5:2.5 ({/Symbol \264}{/=24 10^{/=14 21} POT})}"
set ylabel '{/=24 sin^2{/Symbol q}@_{/=16 23}^{input}' offset 1.5,0
set xlabel '{/=24 {/Symbol d}@_{/=16 MNS}^{input}' offset -0.5,0
#################### plot ##########################################
plot \
"file1.tab" index 0 u xdata:ydata notitle w l lt 1 lc rgb c1 lw 5, \
"file1.tab" index 1 u xdata:ydata notitle w l lt 1 lc rgb c2 lw 5, \
"file1.tab" index 2 u xdata:ydata notitle w l lt 1 lc rgb c3 lw 5, \
"file1.tab" index 3 u xdata:ydata notitle w l lt 1 lc rgb c4 lw 5, \
"file1.tab" index 4 u xdata:ydata notitle w l lt 1 lc rgb c5 lw 5, \
"file2.tab" index 0 u xdata:ydata notitle w l lt 2 lc rgb c1 lw 3, \
"file2.tab" index 1 u xdata:ydata notitle w l lt 2 lc rgb c2 lw 3, \
"file2.tab" index 2 u xdata:ydata notitle w l lt 2 lc rgb c3 lw 3, \
"file2.tab" index 3 u xdata:ydata notitle w l lt 2 lc rgb c4 lw 3, \
"file2.tab" index 4 u xdata:ydata notitle w l lt 2 lc rgb c5 lw 3, \
"file3.tab" index 0 u xdata:ydata notitle w l lt 1 lc rgb c1 lw 3, \
"file3.tab" index 1 u xdata:ydata notitle w l lt 1 lc rgb c2 lw 3, \
"file3.tab" index 2 u xdata:ydata notitle w l lt 1 lc rgb c3 lw 3, \
"file3.tab" index 3 u xdata:ydata notitle w l lt 1 lc rgb c4 lw 3, \
"file3.tab" index 4 u xdata:ydata notitle w l lt 1 lc rgb c5 lw 3
###########################################################################
reset