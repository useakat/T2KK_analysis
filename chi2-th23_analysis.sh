#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

rm -rf temp/params.card
mares=1100

# Please set the 4th argument of minimize_dchi2_2.sh to 4 (in X.sh)
CPmode=CP
fitMH=true

exp=2
L=1040
OAB_SK=2.5
OAB_far=2.3
rho_SK=2.6
rho_far=2.9

run_name=T2HKK_C_chi2-th23_2.7
./makedir.sh rslt_$run_name 1

params_card=params.card_2016.09
#params_card=params.card_2016.09_nosmear
#    params_card=params.card_2016.09_nosmear_nofit
cp -rf temp/$params_card temp/params.card 

./set_param_mode.sh 0 "iSK" 1
./set_param_mode.sh 0 "SV" 122.5
./set_param_mode.sh 0 "SL" 295
./set_param_mode.sh 0 "Srho" 2.6
./set_param_mode.sh 0 "SOAB" $OAB_SK

./set_param_mode.sh 0 "iOKi" 0
./set_param_mode.sh 0 "KV" 100
./set_param_mode.sh 0 "OL" 695
./set_param_mode.sh 0 "Orho" 2.75
./set_param_mode.sh 0 "OOAB" 0.9

./set_param_mode.sh 0 "iKr" 1
./set_param_mode.sh 0 "KV" 100
./set_param_mode.sh 0 "KL" $L
./set_param_mode.sh 0 "Krho" 2.9
./set_param_mode.sh 0 "KOAB" $OAB_far

./set_param_mode.sh 0 "Y" 2.7

CP=0
./set_param.sh "dCP" $CP
./set_param.sh "fdCP" $CP

./set_param.sh "ichi2_thatm" 1

MH=1
th23=0.6
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.5
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.4
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 1
cp -rf run.sh rslt_$run_name/.

MH=-1
th23=0.6
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.5
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.4
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 1
cp -rf run.sh rslt_$run_name/.

xsecCC_dir=`cat $bindir/xsecCC/xsecCC_dir.txt`
xsecNC_dir=`cat $bindir/xsecNC/xsecNC_dir.txt`
echo $xsecCC_dir > rslt_$run_name/xsec_dir.txt
echo $xsecNC_dir >> rslt_$run_name/xsec_dir.txt

cp -rf beam_neu_dir.txt rslt_$run_name/.

date2=`date`
echo ""
echo $date1
echo $date2