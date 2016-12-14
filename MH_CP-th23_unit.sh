#!/bin/bash
maindir=`cat maindir.txt`
job_system=`cat job_system.txt`

run=$1
iDD=$2 # 1:T2KO 2:T2KK
L=$3
OAB_SK=$4
OAB_far=$5
MH=$6
min_th23=$7
max_th23=$8
r_nu=$9
r_anu=${10}
mares=${11}
submit_mode=${12}
CPscan_div=${13}
mail=${14}

que=l  # for KEKCC: e:<10min s:<3h l:<24h h:<1w
######################  Parameters #######################################
# working space for jobs on a remote server
if [ $job_system == "icrr" ];then
    work_dir=/disk/th/work/takaesu/$run
    if [ -e $work_dir ];then
	echo "$work_dir exists. Delete and remake it"
	rm -rf $work_dir
    fi
    mkdir $work_dir
elif [ $job_system == "kekcc" ];then
    work_dir=./
fi

min_CP=-180
max_CP=180
div_CP=20
#div_CP=1

div_th23=1
######################## Parameter check #################################
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
####################### Main Code ########################################
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

rm -rf $outfile
touch $outfile
outdir=rslt_unit_out
./makedir.sh $outdir 1

# submit jobs
prog_mode=1
i=1
th23=$min_th23
xx_th23=`echo "$th23 > $max_th23" | bc`
while [ $xx_th23 -eq 0 ];do
    CP=$min_CP
    xx_CP=`echo "$CP > $max_CP" | bc`
    while [ $xx_CP -eq 0 ];do
	jobname="chi2_oab"$RANDOM
	./submit_job.sh $que $i $jobname "${maindir}/MH_CP-th23.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $submit_mode $CPscan_div $prog_mode" 0 $work_dir 
	i=`expr $i + 1`
	CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
	xx_CP=`echo "$CP > $max_CP" | bc` 
    done
    th23=`echo "scale=5; $th23 + $step_th23" | bc | sed 's/^\./0./'`
    xx_th23=`echo "$th23 > $max_th23" | bc` 
done

if [ $submit_mode -eq 1 ];then
    ./monitor $work_dir
fi

# combine jobs
prog_mode=2
i=1
th23=$min_th23
xx_th23=`echo "$th23 > $max_th23" | bc`
while [ $xx_th23 -eq 0 ];do
    CP=$min_CP
    xx_CP=`echo "$CP > $max_CP" | bc`
    while [ $xx_CP -eq 0 ];do
	jobname="dummy"
	./submit_job.sh $que $i $jobname "${maindir}/MH_CP-th23.sh $iDD $L $OAB_SK $OAB_far $MH $r_nu $r_anu $CP $th23 $submit_mode $CPscan_div $prog_mode" 0 $work_dir 
	i=`expr $i + 1`
	CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
	xx_CP=`echo "$CP > $max_CP" | bc` 
    done
    th23=`echo "scale=5; $th23 + $step_th23" | bc | sed 's/^\./0./'`
    xx_th23=`echo "$th23 > $max_th23" | bc` 
done

if [ $job_system == "icrr" ];then
    cp -rf $work_dir/* .
    rm -rf $work_dir
fi

i=1
th23=$min_th23
xx_th23=`echo "$th23 > $max_th23" | bc`
while [ $xx_th23 -eq 0 ];do
    CP=$min_CP
    xx_CP=`echo "$CP > $max_CP" | bc`
    while [ $xx_CP -eq 0 ];do
	echo $CP $th23 `cat par_$i/rslt_out/data/dchi2.dat` >> $outdir/$outfile
	cp -rf par_$i/rslt_out/CPscan.dat $outdir/CPscan_$CP.dat
#	cp -rf par_$i/rslt_out/result.log $outdir/result_$i.log
	i=`expr $i + 1`
	CP=`echo "scale=5; $CP + $step_CP" | bc | sed 's/^\./0./'`
	xx_CP=`echo "$CP > $max_CP" | bc` 
    done
    echo " " >> $outdir/$outfile
    th23=`echo "scale=5; $th23 + $step_th23" | bc | sed 's/^\./0./'`
    xx_th23=`echo "$th23 > $max_th23" | bc` 
done
cp -rf par_1/rslt_out/params.card $outdir/.
cp -rf par_1/rslt_out/data $outdir/basic_data
echo $maindir > $outdir/program.version
git log --oneline | head -1 | tail -1 >> $outdir/program.version

rm -rf par_*

if [ $mail -eq 1 ]; then
    ./mail_notify $mail $job_system $jobname
fi