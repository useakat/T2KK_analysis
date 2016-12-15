#!/bin/bash
################################################################################
###   Module for getting MH Delta chi^2_min vs. delta_CP data. 
################################################################################
function MH-th23_unit () {
    rm -rf par_*
    ./MH_CP_th23.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 1 $run_mode \
	$CPscan_div 0

}

################################################################################
###   Module for getting MH Delta chi^2_min vs. delta_CP data 
###   with mass hierarchie assumptions. 
################################################################################
function MH-th23_MH () {
    MH=1
    MH-th23_unit
    MH=-1
    MH-th23_unit
}

################################################################################
###   Module for getting MH Delta chi^2_min vs. delta_CP data with various 
###   th_23 angle for an experiment (T2KK/T2KO). 
################################################################################
function MH-th23_analysis () {
    rm -rf temp/params.card
    cp -rf temp/$params_card temp/params.card 
    ./set_param.sh "ichi2_thatm" 0   # for simple calculation of Delta chi^2_MH

    run_name=${exp_name}_MH-th23_${OAB_SK}_${OAB_far}_${L}km_$ext
    ./makedir.sh rslt_$run_name 1
    
    th23=0.6
    MH-th23_MH

    th23=0.5
    MH-th23_MH
    
    th23=0.4
    MH-th23_MH
}    

################################################################################
### MAIN PROGRAM
###############################################################################
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

ext=$1
params_card=$2
run_mode=$3
CPscan_div=$4

## T2KK
exp=2
exp_name=T2KK
L=1000
OAB_SK=2.5
OAB_far=1.0
MH-th23_analysis

### T2KO
exp=1
exp_name=T2KO
L=653
OAB_SK=2.5
OAB_far=0.9
MH-th23_analysis
