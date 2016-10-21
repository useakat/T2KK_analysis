#!/bin/bash

gnuplot mh_cp_th23.gnu
gnuplot chi2_cp.gnu
gnuplot chi2_th23.gnu

rm -rf *.eps

