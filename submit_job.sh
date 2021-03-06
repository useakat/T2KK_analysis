#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: submit_job.sh [que] [i] [jobname] [command] [submit_mode] [work_dir]"
    echo ""
    exit
fi

maindir=`cat maindir.txt`
job_system=`cat job_system.txt`

que=$1
i=$2
jobname=$3
command="$4"
submit_mode=$5
work_dir=$6

njob=bjob

dir=par_$i
if [ $work_dir != "0" ];then
    cd $work_dir
    echo "moved to $work_dir"
fi
$maindir/makedir.sh $dir 0
cd $dir

echo "#!/bin/bash" > $njob$i
echo "" >> $njob$i
if [ $job_system == "icrr" ];then
    echo '#------ pjsub option --------#' >> $njob$i
    echo '#PJM -L "rscunit=common"' >> $njob$i
    echo '#PJM -L "rscgrp=B"' >> $njob$i
#    echo '#PJM -L "rscunit=group"' >> $njob$i
#    echo '#PJM -L "rscgrp=th"' >> $njob$i
    echo '#PJM -L "vnode=1"' >> $njob$i
    echo '#PJM -L "vnode-core=1"' >> $njob$i
#    echo '#PJM -L "vnode-mem=3Gi"' >> $njob$i
#    echo '#PJM -L "elapse=00:15:00"' >> $njob$i # A:<3h B:<24h C:<1week th:no limit
fi
echo '#------- Program execution -------#' >> $njob$i
echo 'start=`date`' >> $njob$i
echo 'echo $start >allprocess.log' >> $njob$i
echo "cp -rf $maindir/monitor ." >> $njob$i
echo "cp -rf $maindir/submit_job.sh ." >> $njob$i
echo "cp -rf $maindir/maindir.txt ." >> $njob$i
echo "cp -rf $maindir/beam_neu_dir.txt ." >> $njob$i
echo "cp -rf $maindir/job_system.txt ." >> $njob$i
echo "chmod +x monitor" >> $njob$i
echo "chmod +x submit_job.sh" >> $njob$i
echo "rm -rf wait.${njob}$i" >> $njob$i
echo "touch run.${njob}$i" >> $njob$i
echo "$command >>allprocess.log 2>&1" >> $njob$i
echo "rm -rf run.${njob}$i" >> $njob$i
echo "touch done.${njob}$i" >> $njob$i
echo 'echo $start >>allprocess.log' >> $njob$i
echo 'date >>allprocess.log' >> $njob$i

chmod +x $njob$i
touch wait.$njob$i

if [ $submit_mode -eq 0 ];then
    echo "job$i launched"
    ./$njob$i
    echo "job$i finished"
    echo
    rm -rf *.${njob}$i
else
    if [ $job_system == "kekcc" ];then
	bsub -q $que -J $jobname ./$njob$i
    elif [ $job_system == "icrr" ];then
	pjsub -N $jobname -j $njob$i
    fi
    echo ""
fi