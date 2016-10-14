#!/bin/bash

###### site C
iKr=1
KL=1040
OAB_Kr=2.3
FV_HK=100
FV_Kr=100
rho_Kr=2.9
POT=27 # * 10^21

./MH_analysis.sh T2HKK_C_MH_${FV_Kr}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
./chi2-CP_analysis.sh T2HKK_C_chi2-CP_${FV_Kr}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
./chi2-th23_analysis.sh T2HKK_C_chi2-th23_${FV_Kr}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT

####### site H
FV_HK=100
POT=27 # * 10^21
iKr=1
KL=1090
OAB_Kr=1.3
FV_Kr=100
rho_Kr=2.9

./MH_analysis.sh T2HKK_H_MH_${FV_Kr}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
./chi2-CP_analysis.sh T2HKK_H_chi2-CP_${FV_Kr}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
./chi2-th23_analysis.sh T2HKK_H_chi2-th23_${FV_Kr}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT

####### HK*2
iKr=0
FV_HK=200
POT=27 # * 10^21
# dummy inputs
KL=295
OAB_Kr=2.5
FV_Kr=100
rho_Kr=2.6

# ./MH_analysis.sh T2HKK_HK_MH_${FV_HK}_$POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# ./chi2-CP_analysis.sh T2HKK_HK_chi2-CP_2.7_187 $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# ./chi2-th23_analysis.sh T2HKK_HK_chi2-th23_2.7_187 $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT