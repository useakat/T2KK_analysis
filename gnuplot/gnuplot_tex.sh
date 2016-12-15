#!/bin/bash

gnu=$1

eps=`grep "set output" $gnu`
eps=${eps##*output \"}
eps=${eps%\"}
sed -e 's/set output .*/set output "figure_tmp.eps"/' $gnu > tmp.gnu
gnuplot tmp.gnu
sed -e "s/figure_tmp/figure_tmp.eps/" figure_tmp.tex > tmp.tex
echo "\documentclass[a4paper,10pt]{article}" > tex-eps.tex
echo "\usepackage{graphicx}" >> tex-eps.tex
echo "\pagestyle{empty}" >> tex-eps.tex
echo "\begin{document}" >> tex-eps.tex
echo "\begin{figure}[htbp]" >> tex-eps.tex
echo "\input{tmp}" >> tex-eps.tex
echo "\end{figure}" >> tex-eps.tex
echo "\end{document}" >> tex-eps.tex
platex tex-eps.tex
dvips -E tex-eps.dvi -o $eps

correct_bbox.sh

clean_tex.sh
rm -rf tex-eps.tex tmp.tex figure_tmp.tex tex-eps.dvi tmp.gnu figure_tmp.eps