#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

run_name=$1
iKr=$2
KL=$3 # km
OAB_Kr=$4 # degree
rho_Kr=$5  # g/cm^3
FV_HK=$6 # kton
FV_Kr=$7 # kton
POT=$8 # * 10^21 POT

#mares=1100

# Please set the 4th argument of minimize_dchi2_2.sh to 4 (in X.sh)
CPmode=CP
fitMH=true

exp=2
OAB_SK=2.5
rho_SK=2.6
SL=295

./makedir.sh rslt_$run_name 1

SV=`echo "scale=3; $FV_HK + 22.5" | bc`

./set_param_mode.sh 0 "iSK" 1
./set_param_mode.sh 0 "SV" $SV
./set_param_mode.sh 0 "SL" $SL
./set_param_mode.sh 0 "Srho" $rho_SK
./set_param_mode.sh 0 "SOAB" $OAB_SK

./set_param_mode.sh 0 "iOKi" 0
./set_param_mode.sh 0 "KV" 100
./set_param_mode.sh 0 "OL" 695
./set_param_mode.sh 0 "Orho" 2.75
./set_param_mode.sh 0 "OOAB" 0.9

./set_param_mode.sh 0 "iKr" $iKr
./set_param_mode.sh 0 "KV" $FV_Kr
./set_param_mode.sh 0 "KL" $KL
./set_param_mode.sh 0 "Krho" $rho_Kr
./set_param_mode.sh 0 "KOAB" $OAB_Kr

./set_param_mode.sh 0 "Y" $POT

CP=0
./set_param.sh "dCP" $CP
./set_param.sh "fdCP" $CP

./set_param.sh "ichi2_thatm" 1

MH=1
th23=0.6
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.5
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.4
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.55
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.45
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 1
cp -rf run.sh rslt_$run_name/.

MH=-1
th23=0.6
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.5
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.4
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.55
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 0
cp -rf run.sh rslt_$run_name/.
th23=0.45
rm -rf par_*
./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP $th23 1
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