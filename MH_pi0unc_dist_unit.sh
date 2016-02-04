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
outdir=pi0unc_${iD}_${th23}
#outdir=test_${iD}_${th23}
makedir.sh $outdir 1
######################## parallel jobs #############################################################
i=1
tot=0
res=0
coh=0
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    jobname="pi0unc_dist"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_pi0unc_dist.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $tot $res $coh $CPscan_mode"
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done
tot=100
res=0
coh=0
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    jobname="chi2"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_pi0unc_dist.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $tot $res $coh $CPscan_mode"
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done
tot=0.11
res=100
coh=100
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    jobname="chi2"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_pi0unc_dist.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $tot $res $coh $CPscan_mode"
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done
tot=0.11
res=0.1
coh=0.15
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    jobname="chi2"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/MH_pi0unc_dist.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $tot $res $coh $CPscan_mode"
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done

monitor

dchi2_1=`cat par_1/rslt_out/data/dchi2.dat`
mv par_1/rslt_out $outdir/rslt_fit_coh0.res0.tot0_0
dchi2_2=`cat par_2/rslt_out/data/dchi2.dat`
mv par_2/rslt_out $outdir/rslt_fit_coh0.res0.tot0_90
dchi2_3=`cat par_3/rslt_out/data/dchi2.dat`
mv par_3/rslt_out $outdir/rslt_fit_coh0.res0.tot0_180
dchi2_4=`cat par_4/rslt_out/data/dchi2.dat`
mv par_4/rslt_out $outdir/rslt_fit_coh0.res0.tot0_270
dchi2_6=`cat par_6/rslt_out/data/dchi2.dat`
mv par_6/rslt_out $outdir/rslt_fit_coh0.res0.tot100_0
dchi2_7=`cat par_7/rslt_out/data/dchi2.dat`
mv par_7/rslt_out $outdir/rslt_fit_coh0.res0.tot100_90
dchi2_8=`cat par_8/rslt_out/data/dchi2.dat`
mv par_8/rslt_out $outdir/rslt_fit_coh0.res0.tot100_180
dchi2_9=`cat par_9/rslt_out/data/dchi2.dat`
mv par_9/rslt_out $outdir/rslt_fit_coh0.res0.tot100_270
dchi2_11=`cat par_11/rslt_out/data/dchi2.dat`
mv par_11/rslt_out $outdir/rslt_fit_coh100.res100.tot0.11_0
dchi2_12=`cat par_12/rslt_out/data/dchi2.dat`
mv par_12/rslt_out $outdir/rslt_fit_coh100.res100.tot0.11_90
dchi2_13=`cat par_13/rslt_out/data/dchi2.dat`
mv par_13/rslt_out $outdir/rslt_fit_coh100.res100.tot0.11_180
dchi2_14=`cat par_14/rslt_out/data/dchi2.dat`
mv par_14/rslt_out $outdir/rslt_fit_coh100.res100.tot0.11_270
dchi2_16=`cat par_16/rslt_out/data/dchi2.dat`
mv par_16/rslt_out $outdir/rslt_fit_coh0.15.res0.1.tot0.11_0
dchi2_17=`cat par_17/rslt_out/data/dchi2.dat`
mv par_17/rslt_out $outdir/rslt_fit_coh0.15.res0.1.tot0.11_90
dchi2_18=`cat par_18/rslt_out/data/dchi2.dat`
mv par_18/rslt_out $outdir/rslt_fit_coh0.15.res0.1.tot0.11_180
dchi2_19=`cat par_19/rslt_out/data/dchi2.dat`
mv par_19/rslt_out $outdir/rslt_fit_coh0.15.res0.1.tot0.11_270

echo $dchi2_1 $dchi2_2 $dchi2_3 $dchi2_4 > dchi2_all.dat
echo $dchi2_6 $dchi2_7 $dchi2_8 $dchi2_9 >> dchi2_all.dat
echo $dchi2_11 $dchi2_12 $dchi2_13 $dchi2_14 >> dchi2_all.dat
echo $dchi2_16 $dchi2_17 $dchi2_18 $dchi2_19 >> dchi2_all.dat
mv dchi2_all.dat $outdir/.
########################################################################################
if [ $mail -eq 1 ]; then
    bsub -q e -J MH_cohunc -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
rm -rf par_*