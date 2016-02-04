###################### Options ###########################################
#set title "gg -> ng Cross Section"
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
####################### Parameters ###############################
vspace = 0.5
hspace = 1
left_margin = 7
right_margin = 1
top_margin = 2
bottom_margin = 3
hcorr = left_margin -right_margin
vcorr = bottom_margin -top_margin
rhcorr = 0.0084*hcorr 
rvcorr = 0.02*vcorr 
####################### Plotting ###############################
set terminal postscript eps enhanced "Times-Roman" color 20
set output "flux.eps"
set grid
set key spacing 1.5 samplen 1

set multiplot layout 2,2

set yrange [1.1E7:2E11]
set logscale y
#################### plot_11 ##########################################
set size 0.5+rhcorr,0.5
set lmargin left_margin
set rmargin hspace/2.
set tmargin top_margin
set bmargin vcorr -vcorr*0.5 +vspace/2.
set title "nu_mu"
set format x ""
set format y "10^{%L}"
set ylabel 'Flux'
plot \
'../rslt_nbeam_oab2.5/data/flux_nm.dat' u 1:2 title "LCS" w steps lt 1 lw 3 lc rgb 'red'
#################### plot_12 ##########################################
set size 0.5,0.5
set lmargin hcorr -hcorr*0.5 +hspace/2.
set rmargin right_margin
set format x ""
set format y ""
set ylabel ""
set title "anu_mu"
set nokey
plot \
'../rslt_nbeam_oab2.5/data/flux_nm.dat' u 1:2 title "LCS" w steps lt 1 lw 3 lc rgb 'red'
################### Plot_21 ########################################### 
set size 0.5+rhcorr,0.5+rvcorr
set lmargin left_margin
set rmargin hspace/2.
set tmargin vspace/2.
set bmargin bottom_margin
set notitle
set format x "%.f"
set xlabel 'E [GeV]' offset 0,0
set format y "10^{%L}"
set ylabel 'Flux' offset 0,0
plot \
'../rslt_nbeam_oab2.5/data/flux_nm.dat' u 1:2 title "LCS" w steps lt 1 lw 3 lc rgb 'red'
################### Plot_22 ########################################### 
set size 0.5,0.5+rvcorr
set lmargin hcorr -hcorr*0.5 +hspace/2.
set rmargin right_margin
set notitle
set format x "%.0f"
set xlabel 'E [GeV]' offset 0,0
set format y ""
set ylabel ""
plot \
'../rslt_nbeam_oab2.5/data/flux_nm.dat' u 1:2 title "LCS" w steps lt 1 lw 3 lc rgb 'red'
###########################################################################
set nomultiplot

reset
