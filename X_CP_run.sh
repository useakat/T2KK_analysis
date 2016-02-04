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
MH=$8
r_nu=$9
r_anu=${10}
X=${11}
CP_input=${12}
mail=${13}
###############################################################################
outdir=${CPmode}_${fitMH}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${r_nu}_${r_anu}_${X}_${CP_input}
#outdir=rslt_${run}_$fitMH}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_${th23}_${r_nu}_${r_anu}
makedir.sh $outdir 1

mares=1100 # default value
./set_mares.sh $mares
#./X_CP.sh $exp $L $OAB_SK $OAB_far $MH $X $CP_input $r_nu $r_anu $mares $fitMH $CPmode 0
./X-Y_input_X-Y_scan.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares $X $X_input $min_X $max_X $div_X $CP $CP_input $min_CP $max_CP $div_CP 0
mv rslt_unit_out/* $outdir/.

#gnufile=mh_cp-th23.gnu
#sed -e "s/file1 =.*/file1 = 'mh_cp-th23_1100'/" \
#    -e gnuplot/$gnufile > $outdir/$gnufile
#cp -rf gnuplot/$gnufile $outdir/.
#cd $outdir
#gnuplot $gnufile
#cd ..

mv $outdir rslt_$run/.

rm -rf rslt_unit_out
date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    bsub -q e -J CP_CP_run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi