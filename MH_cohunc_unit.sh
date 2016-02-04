#!/bin/bash
maindir=`cat maindir.txt`

iDD=$1 # 1:T2KO 2:T2KK
L=$2
OAB_SK=$3
OAB_far=$4
MH=$5
r_nu=$6
r_anu=$7
th23=$8
mail=$9
######################  Parameters ###################################################
que=s  # e:<10min s:<3h l:<24h h:<1w

min_CP=0
max_CP=360
div_CP=4

CPscan_mode=1 # 0:serial CP scan 1:parallel CP scan -1:no scan
######################## Parameter check ###################################################
xx=`echo "$div_CP <= 0" | bc`
if [ $xx -eq 1 ];then
    echo "div_CP should be positive integer. Exiting Program..."
    exit
fi
step_CP=`echo "scale=5; ($max_CP -1*${min_CP})/$div_CP" | bc | sed 's/^\./0./'` 
xx=`echo "$step_CP == 0" | bc`
if [ $xx -eq 1 ];then
    step_CP=1
fi
xx=`echo "$step_CP < 0" | bc`
if [ $xx -eq 1 ];then
    echo "min_CP is larger than max_CP. Exiting program..."
    exit
fi
####################### Main Code ######################################################
if [ $iDD -eq 1 ];then
    iD=t2ko
elif [ $iDD -eq 2 ];then
    iD=t2kk
fi
if [ $MH -eq 1 ];then
    MMH=nh
elif [ $MH -eq -1 ];then
    MMH=ih
fi
outfile=mh_cohunc_${iD}_${MMH}_${r_nu}_${r_anu}_${th23}.dat
rm -rf $outfile
touch $outfile
outdir=rslt_unit_out
makedir.sh $outdir 1

i=1
coh=0
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    jobname="chi2_oab"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_cohunc.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $coh $CPscan_mode"
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done
# coh=0.15
# CP=$min_CP
# xx_CP=`echo "$CP > $max_CP" | bc`
# while [ $xx_CP -eq 0 ];do
#     jobname="chi2_oab"$RANDOM
#     ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_cohunc.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $coh $CPscan_mode"
#     i=`expr $i + 1`
#     CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
#     xx_CP=`echo "$CP > $max_CP" | bc` 
# done
# coh=1
# CP=$min_CP
# xx_CP=`echo "$CP > $max_CP" | bc`
# while [ $xx_CP -eq 0 ];do
#     jobname="chi2_oab"$RANDOM
#     ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_cohunc.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $coh $CPscan_mode"
#     i=`expr $i + 1`
#     CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
#     xx_CP=`echo "$CP > $max_CP" | bc` 
# done

monitor

i=1
coh=0
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    echo $CP $coh `cat par_$i/rslt_out/data/dchi2.dat` `cat par_$i/rslt_out/data/fit_fpico.dat` >> $outdir/$outfile
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done
# coh=0.15
# CP=$min_CP
# xx_CP=`echo "$CP > $max_CP" | bc`
# while [ $xx_CP -eq 0 ];do
#     echo $CP $coh `cat par_$i/rslt_out/data/dchi2.dat` `cat par_$i/rslt_out/data/fit_fpico.dat` >> $outdir/$outfile
#     i=`expr $i + 1`
#     CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
#     xx_CP=`echo "$CP > $max_CP" | bc` 
# done
# coh=1
# CP=$min_CP
# xx_CP=`echo "$CP > $max_CP" | bc`
# while [ $xx_CP -eq 0 ];do
#     echo $CP $coh `cat par_$i/rslt_out/data/dchi2.dat` `cat par_$i/rslt_out/data/fit_fpico.dat` >> $outdir/$outfile
#     i=`expr $i + 1`
#     CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
#     xx_CP=`echo "$CP > $max_CP" | bc` 
# done
echo " " >> $outdir/$outfile

if [ $mail -eq 1 ]; then
    bsub -q e -J MH_cohunc -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
rm -rf par_*