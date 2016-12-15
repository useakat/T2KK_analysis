#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

ext=$1
params_card=$2
run_mode=$3

################################################################################
###    Module of getting chi^2_min for various delta_CP values.
################################################################################
function chi2_CP_run_wrapper () {
this_program=$0

MH=1
CP=0
#./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf $this_program rslt_$run_name/.
CP=90
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf $this_program rslt_$run_name/.
CP=180
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf $this_program rslt_$run_name/.
CP=270
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 1
cp -rf $this_program rslt_$run_name/.

MH=-1
CP=0
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf $this_program rslt_$run_name/.
CP=90
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf $this_program rslt_$run_name/.
CP=180
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf $this_program rslt_$run_name/.
CP=270
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 1
cp -rf $this_program rslt_$run_name/.

}

#################################################################################
###   Module of getting Delta chi^2_min vs delta_CP data for an experiment 
###   (T2KK/T2KO/T2HK).
#################################################################################
function CP_analysis () {
    
    run_name=${exp_name}_CP_${OAB_SK}_${OAB_far}_${L}km_$ext
    ./makedir.sh rslt_$run_name 1

    cp -rf temp/$params_card temp/params.card 

    chi2_CP_run_wrapper
}

#################################################################################
### MAIN PROGRAM
#################################################################################
CPmode=CP
fitMH=true
rho_SK=2.6


### T2KK 
exp=2
exp_name=T2KK
L=1000
rho_far=2.9

## OAB_far = 0.5
OAB_SK=3.0
OAB_far=0.5
CP_analysis

## OAB_far = 1.0
OAB_SK=2.5
OAB_far=1.0
CP_analysis


### T2K0
exp=1
exp_name=T2KO
L=653
rho_far=2.75
OAB_SK=2.5
OAB_far=0.9
CP_analysis


### T2HK
exp=3
exp_name=T2HK
L=295
rho_far=2.6
OAB_SK=2.5
OAB_far=2.5
CP_analysis