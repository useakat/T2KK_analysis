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

### MH sensitivity study (nu vs anti-nu beam ratio)
./makedir.sh rslt_$run_name 1

exp=2
OAB_SK=2.5
rho_SK=2.6
SL=295

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
./set_param_mode.sh 0 "ichi2_thatm" 0

run_mode=1 # 0:serial run 1:parallel run
CPscan_div=8
## Run
MH=1 # True mass hierarcy choice 1:NH -1:IH
th23=0.6 # xa = -0.2
rm -rf par_*
./MH_CP_th23_beam-ratio.sh $run_name $exp $KL $OAB_SK $OAB_Kr $MH $th23 0 $run_mode $CPscan_div 0
th23=0.5 # xa = -0.2
rm -rf par_*
./MH_CP_th23_beam-ratio.sh $run_name $exp $KL $OAB_SK $OAB_Kr $MH $th23 0 $run_mode $CPscan_div 0
th23=0.4 # xa = -0.2
rm -rf par_*
./MH_CP_th23_beam-ratio.sh $run_name $exp $KL $OAB_SK $OAB_Kr $MH $th23 0 $run_mode $CPscan_div 1


MH=-1 # True mass hierarcy choice 1:NH -1:IH
th23=0.6 # xa = -0.2
rm -rf par_*
./MH_CP_th23_beam-ratio.sh $run_name $exp $KL $OAB_SK $OAB_Kr $MH $th23 0 $run_mode $CPscan_div 0
th23=0.5 # xa = -0.2
rm -rf par_*
./MH_CP_th23_beam-ratio.sh $run_name $exp $KL $OAB_SK $OAB_Kr $MH $th23 0 $run_mode $CPscan_div 0
th23=0.4 # xa = -0.2
rm -rf par_*
./MH_CP_th23_beam-ratio.sh $run_name $exp $KL $OAB_SK $OAB_Kr $MH $th23 0 $run_mode $CPscan_div 1

xsecCC_dir=`cat $bindir/xsecCC/xsecCC_dir.txt`
xsecNC_dir=`cat $bindir/xsecNC/xsecNC_dir.txt`
echo $xsecCC_dir > rslt_$run_name/xsec_dir.txt
echo $xsecNC_dir >> rslt_$run_name/xsec_dir.txt

cp -rf beam_neu_dir.txt rslt_$run_name/.

date2=`date`
echo ""
echo $date1
echo $date2