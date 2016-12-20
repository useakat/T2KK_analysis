#!/bin/bash
################################################################################
###    Module 
################################################################################
function chi2_CP_run_unit () {
    nu=$1
    anu=$2
    ./CP_CP_run_2.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK \
	$rho_far $MH $nu $anu $th23 0
}
################################################################################
###    Module 
################################################################################
function chi2_CP_run_MH () {
    MH=$1
    chi2_CP_run_unit 9 1
    chi2_CP_run_unit 7 3
    chi2_CP_run_unit 1 1
    chi2_CP_run_unit 3 7
    chi2_CP_run_unit 1 9
}
#################################################################################
###   Module of getting Delta chi^2_min vs delta_CP data for an experiment 
###   (T2KK/T2KO/T2HK).
#################################################################################
function CP_analysis () {
    run_name=${exp_name}_CP_${OAB_SK}_${OAB_far}_${L}km_$ext
    ./makedir.sh rslt_$run_name 1
    
    cp -rf temp/$params_card temp/params.card 
    th23=0.5
    ./set_param.sh "thatm" $th23
    ./set_param.sh "fthatm" $th23

    chi2_CP_run_MH 1
    chi2_CP_run_MH -1
}
#################################################################################
### MAIN PROGRAM
#################################################################################
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
job_system=`cat job_system.txt`
date1=`date`
echo $date1

ext=$1
params_card=$2
run_mode=$3
mail=$4

echo $ext $params_card $run_mode $mail

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

if [ $mail -eq 1 ]; then
    ./mail_notify $mail $job_system CP_CP
fi