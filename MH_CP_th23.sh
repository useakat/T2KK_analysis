#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
job_system=`cat job_system.txt`
date1=`date`

run=$1
#################  Parameters ###########################################
exp=$2 # 1:T2KO 2:T2KK
if [ $exp -eq 1 ];then
    eexp=t2ko
elif [ $exp -eq 2 ];then
    eexp=t2kk
elif [ $exp -eq 3 ];then
    eexp=t2hk
fi
L=$3
OAB_SK=$4
OAB_far=$5
MH=$6
th23=$7
idirinit=$8
submit_mode=$9
CPscan_div=${10}
mail=${11}
#########################################################################
outdir=${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${th23}_ratio
./makedir.sh $outdir $idirinit

mares=1100

#sed -e "s/ thatm .*/ thatm $th23/" \
#    -e "s/ fthatm .*/ fthatm $th23/" temp/params.card > params_card.tmp
#mv params_card.tmp temp/params.card
th23min=$th23
th23max=$th23

r_nu=1
r_anu=1
./MH_CP-th23_unit.sh $outdir $exp $L $OAB_SK $OAB_far $MH $th23min $th23max $r_nu $r_anu $mares $submit_mode $CPscan_div 0
mv rslt_unit_out/* $outdir/.

if [ -e rslt_$run/$outdir ]; then
    rm -rf rslt_$run/$outdir
    mv $outdir rslt_$run/.
else
    mv $outdir rslt_$run/.
fi

rm -rf rslt_unit_out

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    ./mail_notify $mail $job_system MH_CP_th23
fi