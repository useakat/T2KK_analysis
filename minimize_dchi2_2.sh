#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: minimize_dchi2.sh [run_name] [run_mode] [mail]"
    echo ""
    exit
fi
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
job_system=`cat job_system.txt`
selfdir=$(cd $(dirname $0);pwd)

run=$1
run_mode=$2 # 0:serial 1:parallel
CP_input=$3
test_CP=$4
mail=$5

que=s  # e:<10min s:<3h l:<24h h:<1w

# # working space for jobs on a remote server
# if [ $job_system == "icrr" ];then
#     work_dir=/disk/th/work/takaesu/$run
#     if [ -e $work_dir ];then
# 	echo "$work_dir exists. Delete and remake it"
# 	rm -rf $work_dir
#     fi
#     mkdir $work_dir
# elif [ $job_system == "kekcc" ];then
#     work_dir=./
# fi
work_dir=./

rm -rf rslt_$run
infile=params.card
imax=$test_CP

i=1
CP=$CP_input
while [ $i -le $imax ];do
    dCP[$i]=$CP
    if [ $run_mode -eq 0 ];then
	dir=par_$i
	mkdir -p $dir
	cd $dir
	cp -rf ../maindir.txt .
	cp -rf ../beam_neu_dir.txt .
	sed -e "s/ fdCP .*/ fdCP   ${dCP[$i]}/" ../$infile > $infile
	${bindir}/run.sh run 0 0 0 0
	cd ..
     elif [ $run_mode -eq 1 ];then
#	echo "ERROR: minimize_dchi2_2.sh: Sorry, parallel mode is not implemented yet..."
  	jobname="mindchi2"$RANDOM
  	${maindir}/submit_job.sh $job_system $que $i $jobname "sed -e 's/ fdCP .*/ fdCP   ${dCP[$i]}/' ../$infile > $infile; \
        ${bindir}/run.sh run 0 0 0 0" $run_mode $work_dir
     fi
    i=`expr $i + 1`
    CP=`echo "scale=5; $CP + 360/$imax" | bc`
done
n=$i

 if [ $run_mode -eq 1 ];then
     ./monitor $work_dir
 fi

file1=CPscan.dat
rm -rf $file1
touch $file1
dchi2min=1000000

i=1
while [ $i -lt $n ];do
    dchi2[$i]=`cat par_${i}/rslt_run/data/dchi2.dat`
    echo ${dCP[$i]} ${dchi2[$i]} >> $file1
    comp=`echo "${dchi2[$i]}<$dchi2min" | bc`
    if [ $comp -eq 1 ];then
	dchi2min=${dchi2[$i]}
	index=$i
    fi
    i=`expr $i + 1`
done

i=1
while [ $i -lt $n ];do
    if [ $index -eq $i ];then
	mv par_${i}/rslt_run rslt_$run
    fi
    i=`expr $i + 1`
done

mv $file1 rslt_$run/.
cp -rf $infile rslt_$run/.
rm -rf tmp
rm -rf par_*

if [ $mail -eq 1 ]; then
./mail_notify $mail $job_system $jobname
fi