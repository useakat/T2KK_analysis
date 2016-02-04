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
th23_input=${13}
dmatm_input=${14}
mail=${15}

#th23p=0.1
#th23m=$th23p
#min_th23=`echo "scale=5;$th23_input -$th23m" | bc`
#max_th23=`echo "scale=5;$th23_input +$th23p" | bc`
min_th23=0.3
max_th23=0.8
div_th23=14
min_dmatm=0.0021
max_dmatm=0.0027
div_dmatm=14
###############################################################################
outdir=${CPmode}_${fitMH}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${r_nu}_${r_anu}_${th23_input}_${dmatm_input}
makedir.sh $outdir 1

mares=1100 # default value
#./set_mares.sh $mares
./X-Y_input_X-Y_scan.sh $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH $fitMH $r_nu $r_anu $mares th23 $th23_input $min_th23 $max_th23 $div_th23 dmatm $dmatm_input $min_dmatm $max_dmatm $div_dmatm 0

mv rslt_unit_out/* $outdir/.
cp -rf th23_dmatm_run.sh $outdir/.
if [ -e rslt_$run/$outdir ];then
    rm -rf rslt_$run/$outdir
fi
mv $outdir rslt_$run/.
rm -rf rslt_unit_out

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    bsub -q e -J th23_dmatm_run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi