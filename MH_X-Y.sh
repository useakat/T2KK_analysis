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
X=$8
XX=$9
Y=${10}
YY=${11}
run_mode=${12}

CP_input=0 # default value
#cp -rf ${maindir}/temp/params.card_def.nosmear params.card
#cp -rf ${maindir}/temp/params.card_def params.card
#cp -rf ${maindir}/temp/params.card_oki params.card
cp -rf ${maindir}/temp/params.card_oki_2 params.card
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
fi
sed -e "s/ MH .*/ MH  $MH/" \
    -e "s/ ihypo .*/ ihypo  -1/" \
    -e "s/ r_nu .*/ r_nu  $r_nu/" \
    -e "s/ r_anu .*/ r_anu  $r_anu/" \
    -e "s/ SOAB .*/ SOAB   $OAB_SK/" tmp.card > params.card
if [ $X == "th13" ];then
    sed -e "s/ s2rct_2 .*/ s2rct_2  $XX/" \
	-e "s/ fs2rct_2 .*/ fs2rct_2  $XX/" params.card > tmp.card
elif [ $X == "th23" ];then
    sed -e "s/ thatm .*/ thatm  $XX/" \
	-e "s/ fthatm .*/ fthatm  $XX/" params.card > tmp.card
fi
mv tmp.card params.card
if [ $Y == "CP" ];then
    sed -e "s/ dCP .*/ dCP  $YY/" \
	-e "s/ fdCP .*/ fdCP $YY/" \
	-e "s/ ifit_dCP .*/ ifit_dCP  1/" params.card > tmp.card
    CP_input=$YY
fi
mv tmp.card params.card

if [ $run_mode -ge 0 ];then
#    ${maindir}/minimize_dchi2.sh out $run_mode 0
    ${maindir}/minimize_dchi2_2.sh out $run_mode $CP_input 0
elif [ $run_mode -eq -1 ];then
    ${bindir}/run.sh out 0 0 0 0
fi

rm -rf tmp.card