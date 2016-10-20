#!/bin/bash

### initialize test parameters
ntest=0
npass=0
nfail=0

### test switches
itest1=1
itest2=1
itest3=1
itest4=1
itest5=1
itest6=1

### start tests
KL=1040
OAB_Kr=2.3
rho_Kr=2.9
FV_HK=187
FV_Kr=187
POT=2.7

sed -e "s/scan_mode=1/scan_mode=0/" chi2_scan.sh > tmp.sh
mv tmp.sh chi2_scan.sh
chmod +x chi2_scan.sh

if [ $itest1 -eq 1 ];then
    iKr=1
    ./set_params_card.sh
    ./chi2-CP_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
    params_card_path=rslt_CP_test/CP_true_t2kk_1040_2.5_2.3_1_1_1_0/params.card
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
fi

if [ $itest2 -eq 1 ];then
    iKr=0
    ./set_params_card.sh
    ./chi2-CP_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
    params_card_path=rslt_CP_test/CP_true_t2kk_1040_2.5_2.3_1_1_1_0/params.card
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
fi

if [ $itest3 -eq 1 ];then
    iKr=1
    ./set_params_card.sh
    ./chi2-th23_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
    params_card_path=rslt_CP_test/CP_true_t2kk_1040_2.5_2.3_1_1_1_0_0.6/params.card
    if [ -e $params_card_path ];then
	iKr2=`grep iKr $params_card_path`
	iKr2=${iKr2#*iKr}
	if [ $iKr2 -eq $iKr ];then
	    test3="PASSED iKr=1 test"
	    npass=`expr $npass + 1`
	else
	    test3="FAILED iKr=1 test"
	    nfail=`expr $nfail + 1`
	fi
    else
	test3="FAILED iKr=1 test"
	nfail=`expr $nfail + 1`
    fi
    ntest=`expr $ntest + 1`
fi

if [ $itest4 -eq 1 ];then
    iKr=0
    ./set_params_card.sh
    ./chi2-th23_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
    params_card_path=rslt_CP_test/CP_true_t2kk_1040_2.5_2.3_1_1_1_0_0.6/params.card
    if [ -e $params_card_path ];then
	iKr2=`grep iKr $params_card_path`
	iKr2=${iKr2#*iKr}
	if [ $iKr2 -eq $iKr ];then
	    test4="PASSED iKr=0 test"
	    npass=`expr $npass + 1`
	else
	    test4="FAILED iKr=0 test"
	    nfail=`expr $nfail + 1`
	fi
    else
	test4="FAILED iKr=0 test"
	nfail=`expr $nfail + 1`
    fi
    ntest=`expr $ntest + 1`
fi

if [ $itest5 -eq 1 ];then
    iKr=1
    ./set_params_card.sh
    ./MH_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
    params_card_path=rslt_CP_test/t2kk_1040_2.5_2.3_1_0.6_ratio/params.card
    if [ -e $params_card_path ];then
	iKr2=`grep iKr $params_card_path`
	iKr2=${iKr2#*iKr}
	if [ $iKr2 -eq $iKr ];then
	    test5="PASSED iKr=0 test"
	    npass=`expr $npass + 1`
	else
	    test5="FAILED iKr=0 test"
	    nfail=`expr $nfail + 1`
	fi
    else
	test5="FAILED iKr=0 test"
	nfail=`expr $nfail + 1`
    fi
    ntest=`expr $ntest + 1`
fi

if [ $itest6 -eq 1 ];then
    iKr=0
    ./set_params_card.sh
    ./MH_analysis.sh CP_test $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
    params_card_path=rslt_CP_test/t2kk_1040_2.5_2.3_1_0.6_ratio/params.card
    if [ -e $params_card_path ];then
	iKr2=`grep iKr $params_card_path`
	iKr2=${iKr2#*iKr}
	if [ $iKr2 -eq $iKr ];then
	    test6="PASSED iKr=0 test"
	    npass=`expr $npass + 1`
	else
	    test6="FAILED iKr=0 test"
	    nfail=`expr $nfail + 1`
	fi
    else
	test6="FAILED iKr=0 test"
	nfail=`expr $nfail + 1`
    fi
    ntest=`expr $ntest + 1`
fi

#### display test results
echo ""
echo "$ntest tests"
echo $test1
echo $test2
echo $test3
echo $test4
echo $test5
echo $test6
echo ""
echo "$npass PASSED"
echo "$nfail FAILED"
