####################### Definitions ######################################
c1 = 'red'			
c2 = 'blue'
c3 = '#006400' # dark green
c4 = 'purple'
c5 = '#ff33ff'
c6 = '#cc6600' # dark orange
##########################################################################
set terminal postscript eps enhanced "Times-Roman" color 20
set grid
set key spacing 1.5 samplen 2
#set title "{/=24  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260}), {/Symbol n}:{/Symbol n} = 2.5:2.5 ({/Symbol \264}{/=24 10^{/=14 21} POT})}"
set ylabel '{/=24 {/Symbol Dc^2}' offset 0.5,0
set xlabel '{/=24 {/Symbol d}@_{/=16 MNS}^{input}' offset -0.5,0
set xrange [-180:180]
set yrange [0:50]

line = 10
set output "mh_cp_ratio_0.5.eps"
set multiplot
set label "{/=22  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260})}" at graph 0.55,0.75
set label "{/=22 sin^2{/Symbol q}_{23} = 0.5}" at graph 0.75, graph 0.65
set key at graph 0.95,graph 0.95 spacing 1.5 samplen 2
#################### plot ##########################################
plot \
'< sed "/^ *$/d" mh_cp-th23_1_0_940.dat' every 21::line u 2:3 notitle w l lt 2 lw 3 lc rgb c2 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_0_1100.dat' every 21::line u 2:3 title "{/Symbol n}:{/Symbol n} = 5:0" w l lt 1 lw 5 lc rgb c2 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_0_1210.dat' every 21::line u 2:3 notitle w l lt 1 lw 2 lc rgb c2 smooth csplines
###########################################################################
set key at graph 0.95,graph 0.9
plot \
'< sed "/^ *$/d" mh_cp-th23_1_1_940.dat' every 21::line u 2:3 notitle w l lt 2 lw 3 lc rgb c1 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_1_1100.dat' every 21::line u 2:3 title "2.5:2.5" w l lt 1 lw 5 lc rgb c1 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_1_1210.dat' every 21::line u 2:3 notitle w l lt 1 lw 2 lc rgb c1 smooth csplines
###########################################################################
set nomultiplot
unset label

line = 5
set output "mh_cp_ratio_0.4.eps"
set multiplot
set label "{/=22  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260})}" at graph 0.55,0.75
set label "{/=22 sin^2{/Symbol q}_{23} = 0.4}" at graph 0.75, graph 0.65
set key at graph 0.95,graph 0.95 spacing 1.5 samplen 2
#################### plot ##########################################
plot \
'< sed "/^ *$/d" mh_cp-th23_1_0_940.dat' every 21::line u 2:3 notitle w l lt 2 lw 3 lc rgb c2 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_0_1100.dat' every 21::line u 2:3 title "{/Symbol n}:{/Symbol n} = 5:0" w l lt 1 lw 5 lc rgb c2 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_0_1210.dat' every 21::line u 2:3 notitle w l lt 1 lw 2 lc rgb c2 smooth csplines
###########################################################################
set key at graph 0.95,graph 0.9
plot \
'< sed "/^ *$/d" mh_cp-th23_1_1_940.dat' every 21::line u 2:3 notitle w l lt 2 lw 3 lc rgb c1 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_1_1100.dat' every 21::line u 2:3 title "2.5:2.5" w l lt 1 lw 5 lc rgb c1 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_1_1210.dat' every 21::line u 2:3 notitle w l lt 1 lw 2 lc rgb c1 smooth csplines
###########################################################################
set nomultiplot
unset label

line = 15
set output "mh_cp_ratio_0.6.eps"
set multiplot
set label "{/=22  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260})}" at graph 0.55,0.75
set label "{/=22 sin^2{/Symbol q}_{23} = 0.6}" at graph 0.75, graph 0.65
set key at graph 0.95,graph 0.95 spacing 1.5 samplen 2
#################### plot ##########################################
plot \
'< sed "/^ *$/d" mh_cp-th23_1_0_940.dat' every 21::line u 2:3 notitle w l lt 2 lw 3 lc rgb c2 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_0_1100.dat' every 21::line u 2:3 title "{/Symbol n}:{/Symbol n} = 5:0" w l lt 1 lw 5 lc rgb c2 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_0_1210.dat' every 21::line u 2:3 notitle w l lt 1 lw 2 lc rgb c2 smooth csplines
###########################################################################
set key at graph 0.95,graph 0.9
plot \
'< sed "/^ *$/d" mh_cp-th23_1_1_940.dat' every 21::line u 2:3 notitle w l lt 2 lw 3 lc rgb c1 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_1_1100.dat' every 21::line u 2:3 title "2.5:2.5" w l lt 1 lw 5 lc rgb c1 smooth csplines, \
'< sed "/^ *$/d" mh_cp-th23_1_1_1210.dat' every 21::line u 2:3 notitle w l lt 1 lw 2 lc rgb c1 smooth csplines
###########################################################################
set nomultiplot
reset
