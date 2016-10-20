#!/bin/bash

### initialize test parameters
ntest=0
npass=0
nfail=0

### start tests
KL=1040
OAB_Kr=2.3
rho_Kr=2.9
FV_HK=187
FV_Kr=187
POT=2.7

params_card_path=rslt_CP_test/CP_true_t2kk_1040_2.5_2.3_1_1_1_0/params.card
sed -e "s/scan_mode=1/scan_mode=0/" chi2_scan.sh > tmp.sh
mv tmp.sh chi2_scan.sh
chmod +x chi2_scan.sh

#params_card=params.card_2016.09
#params_card=params.card_2016.09_nosmear
params_card=params.card_2016.09_nosmear_nofit
cp -rf temp/$params_card temp/params.card 

iKr=1
./chi2-CP_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
if [ -e $params_card_path ];then
    iKr2=`grep iKr $params_card_path`
    iKr2=${iKr2#*iKr}
    if [ $iKr2 -eq $iKr ];then
	test1="PASSED iKr=1 test"
	npass=`expr $npass + 1`
    else
	test1="FAILED iKr=1 test"
	nfail=`expr $nfail + 1`
    fi
else
    test1="FAILED iKr=1 test"
    nfail=`expr $nfail + 1`
fi
ntest=`expr $ntest + 1`

#params_card=params.card_2016.09
#params_card=params.card_2016.09_nosmear
params_card=params.card_2016.09_nosmear_nofit
cp -rf temp/$params_card temp/params.card 

iKr=0
./chi2-CP_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
if [ -e $params_card_path ];then
    iKr2=`grep iKr $params_card_path`
    iKr2=${iKr2#*iKr}
    if [ $iKr2 -eq $iKr ];then
	test2="PASSED iKr=0 test"
	npass=`expr $npass + 1`
    else
	test2="FAILED iKr=0 test"
	nfail=`expr $nfail + 1`
    fi
else
    test2="FAILED iKr=0 test"
    nfail=`expr $nfail + 1`
fi
ntest=`expr $ntest + 1`

echo ""
echo "$ntest tests"
echo $test1
echo $test2
echo ""
echo "$npass PASSED"
echo "$nfail FAILED"
