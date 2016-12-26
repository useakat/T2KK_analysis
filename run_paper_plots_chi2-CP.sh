#!/bin/bash
################################################################################
###    Module 
################################################################################
function chi2-CP_run_unit () {
    nu=$1
    anu=$2
    ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH $nu $anu $CP 0
    cp -rf run.sh rslt_$run_name/.
}
#################################################################################
###   Module of getting Delta chi^2_min vs delta_CP data for an experiment 
###   (T2KK/T2KO/T2HK).
#################################################################################
function chi2-CP_analysis () {
    run_name=${exp_name}_chi2-CP_${OAB_SK}_${OAB_far}_${L}km_$ext
    ./makedir.sh rslt_$run_name 1
    
    cp -rf temp/$params_card temp/params.card 
    th23=0.5
    ./set_param.sh "thatm" $th23
    ./set_param.sh "fthatm" $th23

    MH=1
    CP=0
    chi2-CP_run_unit 5 0
    chi2-CP_run_unit 1 1
    chi2-CP_run_unit 0 5

    CP=60
    chi2-CP_run_unit 5 0
    chi2-CP_run_unit 1 1
    chi2-CP_run_unit 0 5

    ./mail_notify 1 $job_system chi2-CP
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

CPmode=CP
fitMH=true
rho_SK=2.6

### T2HK
exp=3
exp_name=T2HK
L=295
rho_far=2.6
OAB_SK=2.5
OAB_far=2.5
chi2-CP_analysis

if [ $mail -eq 1 ]; then
    ./mail_notify $mail $job_system CP_CP
fi