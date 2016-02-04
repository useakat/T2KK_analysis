#!/bin/bash
maindir=`cat maindir.txt`

iDD=$1 # 1:T2KO 2:T2KK 2:T2HK
L=$2
OAB_SK=$3
OAB_far=$4
MH=$5
X_input=$6
CP_input=$7
r_nu=$8
r_anu=$9
mares=${10}
fitMH=${11}
CPmode=${12}
mail=${13}
######################  Parameters ###################################################
que=s  # e:<10min s:<3h l:<24h h:<1w

min_X=0
max_X=0.15
#div_CP=39
div_X=1
#div_CP=1

min_CP=-180
max_CP=180
#div_CP=39
div_CP=1
#div_CP=1

scan_mode=1 # 0:serial X-CP scan 1:parallel X-CP scan
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
    echo "min_CP is larger than max_CP. Exiting program..."
    exit
fi

icheck=`echo "$div_CP <= 0" | bc`
if [ $icheck -eq 1 ];then
    echo "div_CP should be positive integer. Exiting Program..."
    exit
fi

step_CP=`echo "scale=5; ($max_CP -1*${min_CP})/$div_CP" | bc | sed 's/^\./0./'` 
icheck=`echo "$step_CP == 0" | bc`
if [ $icheck -eq 1 ];then
    step_CP=1
fi
icheck=`echo "$step_CP < 0" | bc`
if [ $icheck -eq 1 ];then
    echo "min_CP is larger than max_CP. Exiting program..."
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
outfile=CP_${CPmode}_${fitMH}_${iD}_${MMH}_${r_nu}_${r_anu}_${X}_${CP}.dat
rm -rf $outfile
touch $outfile
outdir=rslt_unit_out
makedir.sh $outdir 1

i=1
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    jobname="cp_cp"$RANDOM
    ./submit_job.sh bsub $que $i $jobname "${maindir}/${CPmode}_${fitMH}MH.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 0" $CPscan_mode
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done

if [ $CPscan_mode -eq 1 ];then
    monitor
fi    

i=1
CP=$min_CP
xx_CP=`echo "$CP > $max_CP" | bc`
while [ $xx_CP -eq 0 ];do
    # line=`grep dCP par_$i/rslt_out/data/fit_params.dat`
    # a=($line)
    # dchi2=`cat par_$i/rslt_out/data/dchi2.dat`
    # if [ $CPmode == "CP" ];then
    # 	echo ${a[2]} ${a[4]} ${a[5]} $dchi2 >> $outdir/$outfile
    # elif [ $CPmode == "CPV" ];then
    # 	echo $CP $dchi2 >> $outdir/$outfile
    # fi
    cat par_$i/rslt_out/CPscan.dat >> $outdir/$outfile
    echo " " >> $outdir/$outfile
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
    xx_CP=`echo "$CP > $max_CP" | bc` 
done
#echo " " >> $outdir/$outfile
cp -rf par_1/rslt_out/params.card $outdir/.

if [ $mail -eq 1 ]; then
    bsub -q e -J CP_CP -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
rm -rf par_*