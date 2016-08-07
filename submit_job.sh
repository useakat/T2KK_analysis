#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: submit_job.sh [job_system] [que] [i] [jobname] [command] [submit_mode] [work_dir]"
    echo ""
    exit
fi

maindir=`cat maindir.txt`

job_system=$1
que=$2
i=$3
jobname=$4
command="$5"
submit_mode=$6
work_dir=$7

njob=bjob

dir=par_$i
cd $work_dir
echo "moved to $work_dir"
mkdir $dir
cd $dir
cp -rf $maindir/maindir.txt .
cp -rf $maindir/beam_neu_dir.txt .

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
else
    if [ $job_system == "kekcc" ];then
#    bsub -q $que -J $jobname ./$njob$i 1>/dev/null
	bsub -q $que -J $jobname ./$njob$i
    elif [ $job_system == "icrr" ];then
	pjsub -N $jobname -j $njob$i
    fi
    echo ""
fi