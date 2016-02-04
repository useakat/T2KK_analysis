#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`

run=$1
mail=$2
#################  Parameters #################################################
exp=$3 # 1:T2KO 2:T2KK
if [ $exp -eq 1 ];then
    eexp=t2ko
elif [ $exp -eq 2 ];then
    eexp=t2kk
fi
L=$4
OAB_SK=$5
OAB_far=$6
MH=$7
r_nu=$8
r_anu=$9
th23=${10}
###############################################################################
outdir=rslt_${run}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${r_nu}_${r_anu}_${th23}
makedir.sh $outdir 1

./MH_cohunc_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $th23 0
mv rslt_unit_out/* $outdir/.

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    bsub -q e -J MH_cohunc -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi