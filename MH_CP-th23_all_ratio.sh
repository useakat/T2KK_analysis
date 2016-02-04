#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`

run=$1
mail=$2
#################  Parameters #################################################
exp=$3 # 1:T2KO 2:T2KK
if [ $exp -eq 1 ];then
    eexp=t2ko
elif [ $exp -eq 2 ];then
    eexp=t2kk
fi
L=$4
OAB_SK=$5
OAB_far=$6
MH=$7
###############################################################################
outdir=rslt_${run}_${eexp}_${L}_${OAB_SK}_${OAB_far}_${MH}_ratio
makedir.sh $outdir 1

mares=1100
r_nu=5
r_anu=0
./set_mares.sh xsecNC_$mares
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.
r_nu=4
r_anu=1
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.
r_nu=3
r_anu=2
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.
r_nu=1
r_anu=1
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.
r_nu=2
r_anu=3
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.
r_nu=1
r_anu=4
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.
r_nu=0
r_anu=5
./MH_CP-th23_unit.sh $exp $L $OAB_SK $OAB_far $MH $r_nu $r_anu $mares 0
mv rslt_unit_out/* $outdir/.

gnufile=mh_cp-th23.gnu
#sed -e "s/file1 =.*/file1 = 'mh_cp-th23_1100'/" \
#    -e gnuplot/$gnufile > $outdir/$gnufile
cp -rf gnuplot/$gnufile $outdir/.
cd $outdir
#gnuplot $gnufile
cd ..

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ]; then
    bsub -q e -J MH_CP-th23 -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi