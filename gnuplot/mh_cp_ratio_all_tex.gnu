####################### Definitions ######################################
c1 = 'red'			
c2 = 'blue'
c3 = '#006400' # dark green
c4 = 'purple'
c5 = '#ff33ff'
c6 = 'orange'
c7 = 'black'

deg = '{/Symbol \260}'
##########################################################################
#set terminal postscript eps enhanced "Times-Roman" color 20
set terminal epslatex 
set grid
set key spacing 1.5 samplen 2
set ylabel '{\large $\left|\overline{\Delta\chi^2_{\rm MH}}\right|$}' offset 0.5,0
set xlabel '{\large $\delta_{\rm CP}$}' offset -0.5,0
set yrange [0:40]
set xrange [-180:180]
set xtics ("-$180^{\\circ}$" -180,"" -150,"" -120,"-$90^{\\circ}$" -90,"" -60,"" -30,"$0^\\circ$" 0,"" 30,"" 60,"$90^\\circ$" 90,"" 120,"" 150,"$180^\\circ$" 180)

set lmargin 7.5

# For NH
legendx = 0.95
legendymax = 0.95
dy = 0.05
label1x = 0.37
label1y = 0.9
label2x = 0.45
label2y = 0.8

# For IH
# legendx = 0.3
# legendymax = 0.99
# dy = 0.05
# label1x = 0.05
# label1y = 0.57
# label2x = 0.05
# label2y = 0.48

set output "mh_cp_ratio_all_t2kk_3.0_nh_tex.eps"
set multiplot
set label "{\\large OAB(SK, Kr) = ($3.0^\\circ, 0.5^\\circ$)}" at graph label1x,label1y
set label "{\\large NH, $\\sin^2\\theta_{23} = 0.5$}" at graph label2x, graph label2y
set key at graph legendx,graph legendymax spacing 1.5 samplen 2
#################### plot ##########################################
plot \
'mh_cp-th23_t2kk_nh_5_0_1100.dat' u 1:3 title "$\\nu$ : $\\bar{\\nu}$ = 5 : 0" w l lt 1 lw 3 lc rgb c2 smooth csplines
###########################################################################
set key at graph legendx,graph legendymax -dy*1.5
plot \
'mh_cp-th23_t2kk_nh_4_1_1100.dat' u 1:3 title "4 : 1" w l lt 1 lw 3 lc rgb c3 smooth csplines
##########################################################################
set key at graph legendx,graph legendymax -dy*3
plot \
'mh_cp-th23_t2kk_nh_3_2_1100.dat' u 1:3 title "3 : 2" w l lt 1 lw 3 lc rgb c6 smooth csplines
###########################################################################
set key at graph legendx,graph legendymax -dy*4.5
plot \
'mh_cp-th23_t2kk_nh_1_1_1100.dat' u 1:3 title "2.5 : 2.5" w l lt 1 lw 3 lc rgb c1 smooth csplines
###########################################################################
set key at graph legendx,graph legendymax -dy*6
plot \
'mh_cp-th23_t2kk_nh_2_3_1100.dat' u 1:3 title "2 : 3" w l lt 2 lw 3 lc rgb c6 smooth csplines
###########################################################################
set key at graph legendx,graph legendymax -dy*7.5
plot \
'mh_cp-th23_t2kk_nh_1_4_1100.dat' u 1:3 title "1 : 4" w l lt 2 lw 3 lc rgb c3 smooth csplines
###########################################################################
set key at graph legendx,graph legendymax -dy*9
plot \
'mh_cp-th23_t2kk_nh_0_5_1100.dat' u 1:3 title "0 : 5" w l lt 2 lw 3 lc rgb c2 smooth csplines
###########################################################################
set nomultiplot
unset label
