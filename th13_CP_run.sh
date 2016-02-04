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
th13_input=${13}
CP_input=${14}
mail=${15}

th13p=0.02
th13m=$th13p
min_th13=`echo "scale=5;$th13_input -$th13m" | bc`
max_th13=`echo "scale=5;$th13_input +$th13p" | bc`
div_th13=9
min_CP=-180
max_CP=180
div_CP=19
###############################################################################
outdir=${CPmode}_${fitMH}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${r_nu}_${r_anu}_${th13_input}_${CP_input}
makedir.sh $outdir 1

mares=1100 # default value
#./set_mares.sh $mares

./X-Y_input_X-Y_scan.sh $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH $fitMH $r_nu $r_anu $mares th13 $th13_input $min_th13 $max_th13 $div_th13 CP $CP_input $min_CP $max_CP $div_CP 0

mv rslt_unit_out/* $outdir/.
cp -rf th13_CP_run.sh $outdir/.
if [ -e rslt_$run/$outdir ];then
    rm -rf rslt_$run/$outdir
fi
mv $outdir rslt_$run/.
rm -rf rslt_unit_out

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    bsub -q e -J CP_CP_run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi