#!/bin/bash
maindir=`cat maindir.txt`

iDD=$1 # 1:T2KO 2:T2KK
L=$2
OAB_SK=$3
OAB_far=$4
MH=$5
r_nu=$6
r_anu=$7
mares=$8
mail=$9
######################  Parameters ###################################################
que=l  # e:<10min s:<3h l:<24h h:<1w

min_CP=-180
max_CP=180
div_CP=19
#div_CP=1

min_th23=0.5  # sin^2 th23
max_th23=0.5
div_th23=1

CPscan_mode=1 # 0:serial CP scan 1:parallel CP scan -1:no scan
######################## Parameter check ###################################################
xx=`echo "$div_CP <= 0" | bc`
if [ $xx -eq 1 ];then
    echo "div_CP should be positive integer. Exiting Program..."
    exit
fi
xx=`echo "$div_th23 <= 0" | bc`
if [ $xx -eq 1 ];then
    echo "div_th23 should be positive integer. Exiting Program..."
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

step_th23=`echo "scale=5; ($max_th23 -1*${min_th23})/$div_th23" | bc | sed 's/^\./0./'` 
xx=`echo "$step_th23 == 0" | bc`
if [ $xx -eq 1 ];then
    step_th23=1
fi
xx=`echo "$step_th23 < 0" | bc`
if [ $xx -eq 1 ];then
    echo "min_th23 is larger than max_th23. Exiting program..."
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
outfile=mh_cp-th23_${iD}_${MMH}_${r_nu}_${r_anu}_${mares}.dat
#outfile=mh_cp-th23_${mares}.dat
rm -rf $outfile
touch $outfile
outdir=rslt_unit_out
makedir.sh $outdir 1

i=1
th23=$min_th23
xx_th23=`echo "$th23 > $max_th23" | bc`
while [ $xx_th23 -eq 0 ];do
    CP=$min_CP
    xx_CP=`echo "$CP > $max_CP" | bc`
    while [ $xx_CP -eq 0 ];do
	jobname="chi2_oab"$RANDOM
	./submit_job.sh bsub $que $i $jobname "${maindir}/MH_CP-th23.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 0" $CPscan_mode
	i=`expr $i + 1`
	CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
	xx_CP=`echo "$CP > $max_CP" | bc` 
    done
    th23=`echo "scale=5; $th23 + $step_th23" | bc | sed 's/^\./0./'`
    xx_th23=`echo "$th23 > $max_th23" | bc` 
done

if [ $CPscan_mode -eq 1 ];then
    monitor
fi

i=1
th23=$min_th23
xx_th23=`echo "$th23 > $max_th23" | bc`
while [ $xx_th23 -eq 0 ];do
    CP=$min_CP
    xx_CP=`echo "$CP > $max_CP" | bc`
    while [ $xx_CP -eq 0 ];do
	echo $CP $th23 `cat par_$i/rslt_out/data/dchi2.dat` >> $outdir/$outfile
	i=`expr $i + 1`
	CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
	xx_CP=`echo "$CP > $max_CP" | bc` 
    done
    echo " " >> $outdir/$outfile
    th23=`echo "scale=5; $th23 + $step_th23" | bc | sed 's/^\./0./'`
    xx_th23=`echo "$th23 > $max_th23" | bc` 
done
cp -rf par_1/rslt_out/params.card $outdir/.

if [ $mail -eq 1 ]; then
    bsub -q e -J MH_CP-th23 -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
rm -rf par_*