#!/bin/bash
################################################################################
###   Module for getting MH Delta chi^2_min vs. delta_CP data with various 
###   nu-anti-nu beam ratio for an experiment (T2KK/T2KO). 
################################################################################
function MH_analysis () {
    run_name=${exp_name}_MH_${OAB_SK}_${OAB_far}_${L}km_$ext
    ./makedir.sh rslt_$run_name 1

    MH=1 # True mass hierarcy choice 1:NH -1:IH
    rm -rf par_*
    ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 \
	$run_mode $CPscan_div 0
    
    MH=-1 # True mass hierarcy choice 1:NH -1:IH
    rm -rf par_*
    ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 \
	$run_mode $CPscan_div 1
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

rm -rf temp/params.card
cp -rf temp/$params_card temp/params.card 
th23=0.5
./set_param.sh "ichi2_thatm" 0   # for simple calculation of Delta chi^2_MH


### T2KK 
exp=2
exp_name=T2KK
L=1000

### OAB_far = 0.5
OAB_SK=3.0
OAB_far=0.5
MH_analysis

### OAB_far = 1.0
OAB_SK=2.5
OAB_far=1.0
MH_analysis


### T2KO
exp=1
exp_name=T2KO
L=653
OAB_SK=2.5
OAB_far=0.9
MH_analysis
