#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`

run=$1
CPmode=$2  # CP: CP measurement  CPV: CPV sensitivity
fitMH=$3 # true: true MH fit  wrong: wrong MH fit
#################  Parameters #################################################
exp=$4 # 1:T2KO 2:T2KK 3:T2HK
if [ $exp -eq 1 ];then
    eexp=t2ko
elif [ $exp -eq 2 ];then
    eexp=t2kk
elif [ $exp -eq 3 ];then
    eexp=t2hk
fi
L=$5
OAB_SK=$6
OAB_far=$7
rho_SK=$8
rho_far=$9
MH=${10}
r_nu=${11}
r_anu=${12}
CP=${13}
X_input=${14}
mail=${15}

min_X=0.35
max_X=0.65
div_X=19
###############################################################################
outdir=${CPmode}_${fitMH}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${r_nu}_${r_anu}_${CP}_${X_input}
makedir.sh $outdir 1

./chi2_scan.sh $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH $fitMH $r_nu $r_anu th23 $X_input $min_X $max_X $div_X 0

cp -rf rslt_unit_out/* $outdir/.
cp -rf chi2_th23_run.sh $outdir/.
if [ -e rslt_$run/$outdir ];then
    rm -rf rslt_$run/$outdir
fi
mv $outdir rslt_$run/.
rm -rf rslt_unit_out

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    bsub -q e -J chi2_th23_run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi