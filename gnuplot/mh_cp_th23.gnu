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
################################################################
fix_bbox = 0  # 0:Do not fix Bounding Box of an eps file  1:Fix Bounding Box
pdf_output = 1  # 0:no pdf conversion 1:pdf conversion
################################################################
set terminal postscript eps enhanced "Times-Roman" color 20
set grid xtics mxtics ytics mytics
set key spacing 1.5 samplen 2
#set title "{/=24  OAB({/=22 SK, Kr}) = (3.0{/Symbol \260}, 0.5{/Symbol \260}), {/Symbol n}:{/Symbol n} = 2.5:2.5 ({/Symbol \264}{/=24 10^{/=14 21} POT})}"
set ylabel '{/=24 {/Symbol Dc^2}_{/=18 min}' offset 0.5,0
set xlabel '{/=24 {/Symbol d}@_{/=16 CP}' offset -0.5,0
set yrange [0:200]
set xrange [-180:180]
#set xtics ("-180".deg -180,"" -150,"" -120,"-90".deg -90,"" -60,"" -30,"0".deg 0,"" 30,"" 60,"90".deg 90,"" 120,"" 150,"180".deg 180)
set xtics ("-180".deg -180,"" -165,"" -150,"-135".deg -135,"" -120,"" -105,"-90".deg -90,"" -75,"" -60,"-45".deg -45,"" -30,"" -15,"0".deg 0,"" 15,"" 30,"45".deg 45,"" 60,"" 75,"90".deg 90,"" 105,"" 120,"135".deg 135,"" 150,"" 165,"180".deg 180)
set ytics ("0" 0,"20" 20,"40" 40,"60" 60,"80" 80,"100" 100,"120" 120,"140" 140,"160" 160,"180" 180,"200" 200)

set lmargin 7.5

legendx = 0.98
legendymax = 0.98
dy = 0.05
label1x = 0.2
label1y = 0.95
label2x = 0.2
label2y = 0.87
label3x = 0.2
label3y = 0.79
label4x = 0.2
label4y = 0.71
label5x = 0.33
label5y = 0.63

output_file = 'T2HKK_'.site.'_MH_'.FV.'kt_'.POT.'POT.eps'
set output output_file
set multiplot
set label "{/=22 OAB({/=22 HK, Kr}) = (2.5{/Symbol \260}, 2.3{/Symbol \260})}" at graph label1x,label1y
set label "{/=22 L(Kr) = 1040 km}" at graph label2x,label2y
set label "{/=22 FV({/=22 HK, Kr}) = (209.5 kton, 187 kton)" at graph label3x,label3y
set label "{/=22 {/Symbol n} : ~{/Symbol n}{.4-} = 13.5 : 13.5 ({/Symbol \264}10^{/=14 21}POT)}" at graph label4x, graph label4y
#set label "{/=22 Normal Hierarchy}" at graph label5x, graph label5y
set label "{/=22 NH (solid), IH (dashed)}" at graph label5x, graph label5y
set key at graph legendx,graph legendymax spacing 1.5 samplen 2
#################### plot ##########################################
 plot \
 'MH/t2kk_'.L.'_2.5_'.OAB_far.'_1_0.6_ratio/mh_cp-th23_t2kk_nh_1_1_1100.dat' u 1:3 title "sin^{/=12 2}{/Symbol q}_{/=12 23} = 0.6" w l lt 1 lw 5 lc rgb c3 smooth csplines
 set key at graph legendx,graph legendymax -dy*1.5
 plot \
 'MH/t2kk_'.L.'_2.5_'.OAB_far.'_1_0.5_ratio/mh_cp-th23_t2kk_nh_1_1_1100.dat' u 1:3 title "0.5" w l lt 1 lw 5 lc rgb c2 smooth csplines
 set key at graph legendx,graph legendymax -dy*3
  plot \
  'MH/t2kk_'.L.'_2.5_'.OAB_far.'_1_0.4_ratio/mh_cp-th23_t2kk_nh_1_1_1100.dat' u 1:3 title "0.4" w l lt 1 lw 5 lc rgb c1 smooth csplines
  set key at graph legendx,graph legendymax -dy*4.5

 plot \
 'MH/t2kk_'.L.'_2.5_'.OAB_far.'_-1_0.6_ratio/mh_cp-th23_t2kk_ih_1_1_1100.dat' u 1:3 notitle w l lt 2 lw 5 lc rgb c3 smooth csplines
 set key at graph legendx,graph legendymax -dy*1.5
 plot \
 'MH/t2kk_'.L.'_2.5_'.OAB_far.'_-1_0.5_ratio/mh_cp-th23_t2kk_ih_1_1_1100.dat' u 1:3 notitle w l lt 2 lw 5 lc rgb c2 smooth csplines
 set key at graph legendx,graph legendymax -dy*3
  plot \
  'MH/t2kk_'.L.'_2.5_'.OAB_far.'_-1_0.4_ratio/mh_cp-th23_t2kk_ih_1_1_1100.dat' u 1:3 notitle w l lt 2 lw 5 lc rgb c1 smooth csplines
  set key at graph legendx,graph legendymax -dy*4.5
########################################################################
set nomultiplot
unset label

################## fix BoundingBox ################################
if (fix_bbox == 1) \
   command = sprintf("epstool --copy --bbox %s tmp.eps", output_file); system command \
   ; command = sprintf("mv tmp.eps %s", output_file); system command \
   ; command = "rm -rf tmp.eps"; system command
if (pdf_output == 1) \
   command = sprintf("ps2pdf -dEPSCrop %s", output_file); system command