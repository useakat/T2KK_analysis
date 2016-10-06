#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

rm -rf temp/params.card
mares=1100

CPmode=CP
fitMH=true

exp=2
L=1040
OAB_SK=2.5
OAB_far=2.3
rho_SK=2.6
rho_far=2.9

run_name=T2HKK_2.5_2.3_1040km_chi2-CP
./makedir.sh rslt_$run_name 1

#    params_card=params.card_new_50MeV
params_card=params.card_new_50MeV_nosmear
#    params_card=params.card_new_50MeV_nosmear_nofit
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

./set_param_mode.sh 0 "Y" 1

./set_param.sh "thatm" 0.5
./set_param.sh "fthatm" 0.5
./set_param.sh "err_thatm" 0.1

MH=1
CP=0
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=90
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=180
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=270
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 1
cp -rf run.sh rslt_$run_name/.

MH=-1
CP=0
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=90
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=180
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=270
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 1
cp -rf run.sh rslt_$run_name/.

fi

xsecCC_dir=`cat $bindir/xsecCC/xsecCC_dir.txt`
xsecNC_dir=`cat $bindir/xsecNC/xsecNC_dir.txt`
echo $xsecCC_dir > rslt_$run_name/xsec_dir.txt
echo $xsecNC_dir >> rslt_$run_name/xsec_dir.txt

cp -rf beam_neu_dir.txt rslt_$run_name/.

date2=`date`
echo ""
echo $date1
echo $date2