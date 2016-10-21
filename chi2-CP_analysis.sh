#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

rm -rf par_*

run_name=$1
iKr=$2
KL=$3 # km
OAB_Kr=$4 # degree
rho_Kr=$5  # g/cm^3
FV_HK=$6 # kton
FV_Kr=$7 # kton
POT=$8 # * 10^21 POT

CPmode=CP
fitMH=true

exp=2
OAB_SK=2.5
rho_SK=2.6
SL=295

./makedir.sh rslt_$run_name 1

./set_param.sh "thatm" 0.5
./set_param.sh "fthatm" 0.5
./set_param.sh "err_thatm" 0.05

MH=1
CP=0
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=90
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=180
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=270
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 1
cp -rf run.sh rslt_$run_name/.

MH=-1
CP=0
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=90
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=180
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 0
cp -rf run.sh rslt_$run_name/.
CP=270
./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $KL $OAB_SK $OAB_Kr $rho_SK $rho_Kr $MH 1 1 $CP 1
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