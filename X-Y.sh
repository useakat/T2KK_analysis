#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
selfdir=$(cd $(dirname $0);pwd)

iDD=$1 # 1:T2KO 2:T2KK
L=$2
OAB_SK=$3
OAB_far=$4
rho_SK=$5
rho_far=$6
MH=$7
fitMH=$8
r_nu=$9
r_anu=${10}
X=${11}
X_input=${12}
XX=${13}
Y=${14}
Y_input=${15}
YY=${16}
run_mode=${17}

CP_input=0 # default value
cp -rf ${maindir}/temp/params.card .

if [ $MH -eq 1 ];then
    MHH="nh"
elif [ $MH -eq -1 ];then
    MHH="ih"
fi
if [ $fitMH == "true" ];then
    ihypo=1
elif [ $fitMH == "wrong" ];then
    ihypo=-1
fi

sed -e "s/ MH .*/ MH  $MH/" \
    -e "s/ ihypo .*/ ihypo  $ihypo/" \
    -e "s/ r_nu .*/ r_nu  $r_nu/" \
    -e "s/ r_anu .*/ r_anu  $r_anu/" \
    -e "s/iSK .*/iSK   1/" \
    -e "s/ Srho .*/ Srho  $rho_SK/" \
    -e "s/ SOAB .*/ SOAB   $OAB_SK/" params.card > tmp.card
if [ $iDD -eq 1 ];then # T2KO
    sed	-e "s/iOki .*/iOki  1/" \
	-e "s/ Orho .*/ Orho  $rho_far/" \
	-e "s/ OL .*/ OL  $L/" \
	-e "s/ OOAB .*/ OOAB   $OAB_far/" \
	-e "s/iKr .*/iKr   0/" tmp.card > params.card
elif [ $iDD -eq 2 ];then # T2KK
    sed -e "s/iOki .*/iOki  0/" \
	-e "s/ Krho .*/ Krho  $rho_far/" \
	-e "s/ KL .*/ KL  $L/" \
	-e "s/ KOAB .*/ KOAB   $OAB_far/" \
	-e "s/iKr .*/iKr   1/" tmp.card > params.card
elif [ $iDD -eq 3 ];then # T2HK (HK = 100kton +SK)
  sed -e "s/iOki .*/iOki  1/" \
	-e "s/ Orho .*/Orho  $rho_far/" \
	-e "s/ OL .*/ OL  $L/" \
	-e "s/ OOAB .*/ OOAB   $OAB_far/" \
	-e "s/iKr .*/iKr   0/" tmp.card > params.card
fi

if [ $X == "th13" ];then
    sed -e "s/ s2rct_2 .*/ s2rct_2  $X_input/" \
	-e "s/ fs2rct_2 .*/ fs2rct_2  $XX/" \
	-e "s/ ifit_s2rct_2 .*/ ifit_s2rct_2 0/" params.card > tmp.card
elif [ $X == "th23" ];then
    sed -e "s/ thatm .*/ thatm  $X_input/" \
	-e "s/ fthatm .*/ fthatm  $XX/" \
	-e "s/ ifit_thatm .*/ ifit_thatm 0/" params.card > tmp.card
elif [ $X == "CP_input" ];then
	sed -e "s/ dCP .*/ dCP  $XX/" params.card > tmp.card
fi
mv tmp.card params.card
if [ $Y == "CP_test" ];then
    sed -e "s/ fdCP .*/ fdCP $YY/" \
	-e "s/ ifit_dCP .*/ ifit_dCP 0/" params.card > tmp.card
    CP_input=$YY
elif [ $Y == "CP" ];then
    sed	-e "s/ dCP .*/ dCP  $Y_input/" \
	-e "s/ fdCP .*/ fdCP $YY/" \
	-e "s/ ifit_dCP .*/ ifit_dCP 0/" params.card > tmp.card
    CP_input=$YY
elif [ $Y == "dmatm" ];then
    sed	-e "s/ dmatm_2 .*/ dmatm_2  $Y_input/" \
	-e "s/ fdmatm_2 .*/ fdmatm_2 $YY/" \
	-e "s/ ifit_dmatm_2 .*/ ifit_dmatm_2 0/" params.card > tmp.card
fi
mv tmp.card params.card

if [ $run_mode -ge 0 ];then
#    ${maindir}/minimize_dchi2.sh out $run_mode 0
#    ${maindir}/minimize_dchi2_2.sh out $run_mode $CP_input 1 0
    prog_mode=0
    ${maindir}/minimize_dchi2_3.sh out $prog_mode $run_mode $CP_input 1 0
#    ${maindir}/minimize_dchi2_th23.sh out $run_mode 0.4 3 0
elif [ $run_mode -eq -1 ];then
    ${bindir}/run.sh out 0 0 0 0
fi

rm -rf tmp.card