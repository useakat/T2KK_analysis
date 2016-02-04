#!/bin/bash
maindir=`cat maindir.txt`

iDD=$1 # 1:T2KO 2:T2KK
L=$2
OAB_SK=$3
OAB_far=$4
rho_SK=$5
rho_far=$6
MH=$7
fitMH=$8
r_nu=$9
r_anu=${10}
X=${11}
X_input=${12}
min_X=${13}
max_X=${14}
div_X=${15}
mail=${16}
######################  Parameters ###################################################
que=s  # e:<10min s:<3h l:<24h h:<1w
scan_mode=1 # 0:serial X-Y scan 1:parallel X-Y scan
######################## Parameter check ###################################################
icheck=`echo "$div_X <= 0" | bc`
if [ $icheck -eq 1 ];then
    echo "div_X should be positive integer. Exiting Program..."
    exit
fi
step_X=`echo "scale=5; ($max_X -1*${min_X})/$div_X" | bc | sed 's/^\./0./'` 
icheck=`echo "$step_X == 0" | bc`
if [ $icheck -eq 1 ];then
    step_X=1
fi
icheck=`echo "$step_X < 0" | bc`
if [ $icheck -eq 1 ];then
    echo "min_X is larger than max_X. Exiting program..."
    exit
fi
####################### Main Code ######################################################
if [ $iDD -eq 1 ];then
    iD=t2ko
elif [ $iDD -eq 2 ];then
    iD=t2kk
elif [ $iDD -eq 3 ];then
    iD=t2hk
fi
if [ $MH -eq 1 ];then
    MMH=nh
elif [ $MH -eq -1 ];then
    MMH=ih
fi
outfile=mh_${X}_${iD}_${MMH}_${fitMH}_${r_nu}_${r_anu}_${X_input}.dat
outfile2=pulls.dat
outfile3=pulls_all.dat
outdir=rslt_unit_out
makedir.sh $outdir 1

i=1
XX=$min_X
icheck_X=`echo "$XX > $max_X" | bc`
while [ $icheck_X -eq 0 ];do
    jobname="chi2_oab"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/X.sh $iDD $L $OAB_SK $OAB_far $rho_SK $rho_far $MH $fitMH $r_nu $r_anu $X $X_input $XX 0" $scan_mode
    i=`expr $i + 1`
    XX=`echo "scale=5; $XX + $step_X" | bc | sed 's/^\./0./'`
    icheck_X=`echo "$XX > $max_X" | bc` 
done

monitor

i=1
XX=$min_X
icheck_X=`echo "$XX > $max_X" | bc`
while [ $icheck_X -eq 0 ];do
    echo $XX `cat par_$i/rslt_out/data/dchi2.dat` >> $outdir/$outfile
    echo $XX `cat par_$i/rslt_out/data/pulls.dat` >> $outdir/$outfile2
    echo $XX `cat par_$i/rslt_out/data/pulls_all.dat` >> $outdir/$outfile3
    i=`expr $i + 1`
    XX=`echo "scale=5; $XX + $step_X" | bc | sed 's/^\./0./'`
    icheck_X=`echo "$XX > $max_X" | bc` 
done
cp -rf par_1/rslt_out/params.card $outdir/.
cp -rf chi2_scan.sh $outdir/.
cp -rf X.sh $outdir/.

if [ $mail -eq 1 ]; then
    bsub -q e -J chi2_scan -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
rm -rf par_*