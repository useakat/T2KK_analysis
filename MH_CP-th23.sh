#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`

iDD=$1 # 1:T2KO 2:T2KK
L=$2
OAB_SK=$3
OAB_far=$4
MH=$5
r_nu=$6
r_anu=$7
CP=$8
th23=$9
run_mode=${10} # 0:CP serial check 1:CP parallel check (not implemented yet)
CPscan_div=${11}
prog_mode=${12}

cp -rf ${maindir}/temp/params.card .
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
elif [ $iDD -eq 3 ];then # T2HK (HK = 100kton +SK)
  sed -e "s/iOki .*/iOki  1/" \
	-e "s/ Orho .*/Orho  $rho_far/" \
	-e "s/ OL .*/ OL  $L/" \
	-e "s/ OOAB .*/ OOAB   $OAB_far/" \
	-e "s/iKr .*/iKr   0/" params.card > tmp.card
fi
# sed -n "/iinput/,/dCP/p" tmp.card > tmp2.card
# line=`grep ithatm tmp2.card`
# line2=${line#*ithatm}
# line3=${line2%%\!*}
# line4=${line3%%ioct*}
# if [ $line4 -eq 1 ];then
#     th23=`echo "scale=5; 4*$th23 -4*$th23^2" | bc | sed 's/^\./0./'`
# fi
sed -e "s/ dCP .*/ dCP  $CP/" \
    -e "s/ fdCP .*/ fdCP $CP/" \
    -e "s/ ifit_dCP .*/ ifit_dCP  1/" \
    -e "s/ thatm .*/ thatm  $th23/" \
    -e "s/ fthatm .*/ fthatm  $th23/" \
    -e "s/ r_nu .*/ r_nu  $r_nu/" \
    -e "s/ r_anu .*/ r_anu  $r_anu/" \
    -e "s/ MH .*/ MH  $MH/" \
    -e "s/ ihypo .*/ ihypo  -1/" \
    -e "s/ SOAB .*/ SOAB   $OAB_SK/" tmp.card > params.card

if [ $run_mode -ge 0 ];then
    ${maindir}/minimize_dchi2_3.sh out $prog_mode $run_mode $CP $CPscan_div 0 
elif [ $run_mode -eq -1 ];then
    ${bindir}/run.sh out 0 0 0 0
fi

rm -rf tmp.card