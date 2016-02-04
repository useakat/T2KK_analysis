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
X=$9
min_X=${10}
max_X=${11}
div_X=${12}
Y=${13}
min_Y=${14}
max_Y=${15}
div_Y=${16}
mail=${17}
######################  Parameters ###################################################
que=s  # e:<10min s:<3h l:<24h h:<1w
scan_mode=1 # 0:serial X-Y scan 1:parallel X-Y scan
######################## Parameter check ###################################################
icheck=`echo "$div_X <= 0" | bc`
if [ $icheck -eq 1 ];then
    echo "div_X should be positive integer. Exiting Program..."
    exit
fi
icheck=`echo "$div_Y <= 0" | bc`
if [ $icheck -eq 1 ];then
    echo "div_Y should be positive integer. Exiting Program..."
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

step_Y=`echo "scale=5; ($max_Y -1*${min_Y})/$div_Y" | bc | sed 's/^\./0./'` 
icheck=`echo "$step_Y == 0" | bc`
if [ $icheck -eq 1 ];then
    step_Y=1
fi
icheck=`echo "$step_Y < 0" | bc`
if [ $icheck -eq 1 ];then
    echo "min_Y is larger than max_Y. Exiting program..."
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
outfile=mh_${X}-${Y}_${iD}_${MMH}_${r_nu}_${r_anu}_${mares}.dat
#outfile=mh_cp-th23_${mares}.dat
rm -rf $outfile
touch $outfile
outdir=rslt_unit_out
makedir.sh $outdir 1

i=1
XX=$min_X
xx_X=`echo "$XX > $max_X" | bc`
while [ $xx_X -eq 0 ];do
    YY=$min_Y
    xx_Y=`echo "$YY > $max_Y" | bc`
    while [ $xx_Y -eq 0 ];do
	jobname="chi2_oab"$RANDOM
	./submit_job.sh bsub $que $i $jobname "${maindir}/MH_X-Y.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $X $XX $Y $YY 0" $scan_mode
	i=`expr $i + 1`
	YY=`echo "scale=5; $YY + $step_Y" | bc | sed 's/^\./0./'`
	xx_Y=`echo "$YY > $max_Y" | bc` 
    done
    XX=`echo "scale=5; $XX + $step_X" | bc | sed 's/^\./0./'`
    xx_X=`echo "$XX > $max_X" | bc` 
done

monitor

i=1
XX=$min_X
xx_X=`echo "$XX > $max_X" | bc`
while [ $xx_X -eq 0 ];do
    YY=$min_Y
    xx_Y=`echo "$YY > $max_Y" | bc`
    while [ $xx_Y -eq 0 ];do
	echo $XX $YY `cat par_$i/rslt_out/data/dchi2.dat` >> $outdir/$outfile
	i=`expr $i + 1`
	YY=`echo "scale=5; $YY + $step_Y" | bc | sed 's/^\./0./'`
	xx_Y=`echo "$YY > $max_Y" | bc` 
    done
    echo " " >> $outdir/$outfile
    XX=`echo "scale=5; $XX + $step_X" | bc | sed 's/^\./0./'`
    xx_X=`echo "$XX > $max_X" | bc` 
done
cp -rf par_1/rslt_out/params.card $outdir/.

if [ $mail -eq 1 ]; then
    bsub -q e -J MH_X-Y -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
rm -rf par_*