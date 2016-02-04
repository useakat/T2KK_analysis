#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
selfdir=$(cd $(dirname $0);pwd)

iDD=$1 # 1:T2KO 2:T2KK
L=$2
OAB_SK=$3
OAB_far=$4
MH=$5
r_nu=$6
r_anu=$7
CP=$8
th23=$9
run_mode=${10}

cp -rf ${maindir}/temp/params.card_def params.card
#cp -rf ${maindir}/temp/params.card_def_nosmear params.card
#cp -rf ${maindir}/temp/params.card_def params.card
#cp -rf ${maindir}/temp/params.card_test params.card
#cp -rf ${maindir}/temp/params.card_oki params.card
#cp -rf ${maindir}/temp/params.card_re params.card
if [ $MH -eq 1 ];then
    MHH="nh"
elif [ $MH -eq -1 ];then
    MHH="ih"
fi
if [ $iDD -eq 1 ];then # T2KO
    sed -e "s/iSK .*/iSK   1/" \
	-e "s/iOki .*/iOki  1/" \
	-e "s/ OL .*/ OL  $L/" \
	-e "s/ OOAB .*/ OOAB   $OAB_far/" \
	-e "s/iKr .*/iKr   0/" params.card > tmp.card
elif [ $iDD -eq 2 ];then # T2KK
    sed -e "s/iSK .*/iSK   1/" \
	-e "s/iOki .*/iOki  0/" \
	-e "s/ KOAB .*/ KOAB   $OAB_far/" \
	-e "s/ KL .*/ KL  $L/" \
	-e "s/iKr .*/iKr   1/" params.card > tmp.card
elif [ $iDD -eq 3 ];then # T2HK
    sed -e "s/iSK .*/iSK   0/" \
	-e "s/iOki .*/iOki  1/" \
	-e "s/ Orho .*/ Orho  2.60/" \
	-e "s/ OV .*/ OV  560/" \
	-e "s/ OL .*/ OL  $L/" \
	-e "s/ OOAB .*/ OOAB   $OAB_far/" \
	-e "s/iKr .*/iKr   0/" params.card > tmp.card
fi
sed -e "s/ dCP .*/ dCP  $CP/" \
    -e "s/ fdCP .*/ fdCP 0/" \
    -e "s/ ifit_dCP .*/ ifit_dCP  0/" \
    -e "s/ thatm .*/ thatm  $th23/" \
    -e "s/ fthatm .*/ fthatm  $th23/" \
    -e "s/ r_nu .*/ r_nu  $r_nu/" \
    -e "s/ r_anu .*/ r_anu  $r_anu/" \
    -e "s/ MH .*/ MH  $MH/" \
    -e "s/ ihypo .*/ ihypo  1/" \
    -e "s/ SOAB .*/ SOAB   $OAB_SK/" tmp.card > params.card
### set other parameters
#sed -e "s/ ismear .*/ ismear  0/" params.card > tmp.card
#mv tmp.card params.card

if [ $run_mode -ge 0 ];then
#    ${maindir}/minimize_dchi2.sh out $run_mode 0
    ${maindir}/minimize_dchi2_2.sh out $run_mode 0 0
elif [ $run_mode -eq -1 ];then
    ${bindir}/run.sh out 0 0 0 0
fi

rm -rf tmp.card