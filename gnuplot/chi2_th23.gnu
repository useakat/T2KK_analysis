####################### Definitions ######################################
c1 = 'red'			
c2 = 'blue'
c3 = 'web-green' # dark green
c4 = 'purple'
c5 = '#ff33ff'
c6 = 'orange'
c7 = 'black'

site = 'C'
L = '1040'
OAB_far = '2.3'
FV = '187'
POT = '27'

deg = '{/Symbol \260}'
##########################################################################
fix_bbox = 0  # 0:Do not fix Bounding Box of an eps file  1:Fix Bounding Box
pdf_output = 1  # 0:no pdf conversion 1:pdf conversion
#############################################################################
set terminal postscript eps enhanced "Times-Roman" color 18
set grid xtics mxtics ytics mytics
set key spacing 1.5 samplen 2
#set title "{/=24  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260}), {/Symbol n}:{/Symbol n} = 2.5:2.5 ({/Symbol \264}{/=24 10^{/=14 21} POT})}"
set ylabel '{/=24 {/Symbol c^2} (sin^{/=14 2}{/Symbol q}_{/=12 23})   - {/Symbol c^2}_{/=18 min}}' offset 1,0
set xlabel 'sin^{/=14 2}{/Symbol q}_{/=12 23}' offset -0.5,0
set yrange [0:100]
set xrange [0.35:0.65]
#set xtics ("-180".deg -180,"" -150,"" -120,"-90".deg -90,"" -60,"" -30,"0".deg 0,"" 30,"" 60,"90".deg 90,"" 120,"" 150,"180".deg 180)
set mxtics 5

set lmargin 7.5

legendx = 0.69
legendymax = 0.95
dy = 0.05
label1x = 0.35
label1y = 0.67
label2x = 0.35
label2y = 0.59
label3x = 0.35
label3y = 0.51
label4x = 0.35
label4y = 0.43
label5x = 0.35
label5y = 0.35
label6x = 0.35
label6y = 0.27

output_file = 'T2HKK_'.site.'_chi2-th23_'.FV.'kt_'.POT.'POT.eps'
set output output_file
set multiplot
set label "{/=19 OAB(HK, Kr) = (2.5{/Symbol \260}, 2.3{/Symbol \260})}" at graph label1x,label1y
set label "{/=19 L(Kr) = 1040 km}" at graph label2x,label2y
set label "{/=19 FV(HK, Kr) = (209.5 kton, 187 kton)" at graph label3x,label3y
set label "{/=19 {/Symbol n} : ~{/Symbol n}{.4-} = 13.5 : 13.5 ({/Symbol \264}10^{/=12 21}POT)}" at graph label4x, graph label4y
set label "{/=19 {/Symbol d}_{/=13 CP} (true) = 0".deg  at graph label5x, graph label5y
set label "{/=19 NH (solid), IH (dashed)}" at graph label6x, graph label6y
set key at graph legendx,graph legendymax spacing 1.5 samplen 2
#################### plot ##########################################
plot \
'chi2-th23/CP_true_t2kk_'.L.'_2.5_'.OAB_far.'_1_1_1_0_0.6/mh_th23_t2kk_nh_true_1_1_0.6.dat' u 1:($2-4) title "sin^{/=14 2}{/Symbol q}_{/=12 23}(true) = 0.6" w l lt 1 lw 5 lc rgb c3 smooth csplines
set key at graph legendx,graph legendymax -dy*1.5
plot \
'chi2-th23/CP_true_t2kk_'.L.'_2.5_'.OAB_far.'_1_1_1_0_0.5/mh_th23_t2kk_nh_true_1_1_0.5.dat' u 1:2 title "0.5" w l lt 1 lw 5 lc rgb c2 smooth csplines
set key at graph legendx,graph legendymax -dy*3
plot \
'chi2-th23/CP_true_t2kk_'.L.'_2.5_'.OAB_far.'_1_1_1_0_0.4/mh_th23_t2kk_nh_true_1_1_0.4.dat' u 1:($2-4) title "0.4" w l lt 1 lw 5 lc rgb c1 smooth csplines
set key at graph legendx,graph legendymax -dy*4.5

plot \
'chi2-th23/CP_true_t2kk_'.L.'_2.5_'.OAB_far.'_-1_1_1_0_0.6/mh_th23_t2kk_ih_true_1_1_0.6.dat' u 1:($2-4) notitle w l lt 2 lw 5 lc rgb c3 smooth csplines
set key at graph legendx,graph legendymax -dy*1.5
plot \
'chi2-th23/CP_true_t2kk_'.L.'_2.5_'.OAB_far.'_-1_1_1_0_0.5/mh_th23_t2kk_ih_true_1_1_0.5.dat' u 1:2 notitle w l lt 2 lw 5 lc rgb c2 smooth csplines
set key at graph legendx,graph legendymax -dy*3
plot \
'chi2-th23/CP_true_t2kk_'.L.'_2.5_'.OAB_far.'_-1_1_1_0_0.4/mh_th23_t2kk_ih_true_1_1_0.4.dat' u 1:($2-4) notitle w l lt 2 lw 5 lc rgb c1 smooth csplines
set key at graph legendx,graph legendymax -dy*4.5

plot 1 notitle lt 2 lc rgb c1
plot 4 notitle lt 2 lc rgb c1
plot 9 notitle lt 2 lc rgb c1
###########################################################################
set nomultiplot
unset label

################## fix BoundingBox ################################
if (fix_bbox == 1) \
   command = sprintf("epstool --copy --bbox %s tmp.eps", output_file); system command \
   ; command = sprintf("mv tmp.eps %s", output_file); system command \
   ; command = "rm -rf tmp.eps"; system command
if (pdf_output == 1) \
   command = sprintf("ps2pdf -dEPSCrop %s", output_file); system command