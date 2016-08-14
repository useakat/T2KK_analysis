#!/bin/bash
maindir=`cat maindir.txt`
job_system=`cat job_system.txt`

rundir=$1
iDD=$2 # 1:T2KO 2:T2KK
L=$3
OAB_SK=$4
OAB_far=$5
rho_SK=$6
rho_far=$7
MH=$8
fitMH=$9
r_nu=${10}
r_anu=${11}
X=${12}
X_input=${13}
min_X=${14}
max_X=${15}
div_X=${16}
mail=${17}
######################  Parameters ######################################
que=s  # e:<10min s:<3h l:<24h h:<1w
scan_mode=1 # 0:serial X-Y scan 1:parallel X-Y scan
######################## Parameter check ################################
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
####################### Main Code #######################################
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
./makedir.sh $outdir 1

# working space for jobs on a remote server
if [ $job_system == "icrr" ];then
    work_dir=/disk/th/work/takaesu/$rundir
    if [ -e $work_dir ];then
	echo "$work_dir exists. Delete and remake it"
	rm -rf $work_dir
    fi
    mkdir $work_dir
elif [ $job_system == "kekcc" ];then
    work_dir=./
fi

i=1
XX=$min_X
icheck_X=`echo "$XX > $max_X" | bc`
while [ $icheck_X -eq 0 ];do
    jobname="chi2_oab"$RANDOM
    ./submit_job.sh $que $i $jobname "${maindir}/X.sh $iDD $L $OAB_SK $OAB_far $rho_SK $rho_far $MH $fitMH $r_nu $r_anu $X $X_input $XX 0" $scan_mode $work_dir
    i=`expr $i + 1`
    XX=`echo "scale=5; $XX + $step_X" | bc | sed 's/^\./0./'`
    icheck_X=`echo "$XX > $max_X" | bc` 
done

if [ $scan_mode -eq 1 ];then
    ./monitor $work_dir
fi
if [ $job_system == "icrr" ];then
    cp -rf $work_dir/* .
    rm -rf $work_dir
fi

i=1
XX=$min_X
icheck_X=`echo "$XX > $max_X" | bc`
while [ $icheck_X -eq 0 ];do
    echo $XX `cat par_$i/rslt_out/data/dchi2.dat` >> $outdir/$outfile
    echo $XX `cat par_$i/rslt_out/data/pulls.dat` >> $outdir/$outfile2
    echo $XX `cat par_$i/rslt_out/data/pulls_all.dat` >> $outdir/$outfile3
#    echo $XX `cat par_$i/rslt_out/` >> $outdir/$outfile3
    i=`expr $i + 1`
    XX=`echo "scale=5; $XX + $step_X" | bc | sed 's/^\./0./'`
    icheck_X=`echo "$XX > $max_X" | bc` 
done
cp -rf par_1/rslt_out/params.card $outdir/.
cp -rf chi2_scan.sh $outdir/.
cp -rf X.sh $outdir/.

if [ $mail -eq 1 ]; then
    ./mail_notify $mail $job_system $jobname
fi
#rm -rf par_*