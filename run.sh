#!/bin/bash

POT=2.7 # * 10^21

###### site C
iKr=1
KL=1040
OAB_Kr=2.3
rho_Kr=2.9
FV_HK=187
FV_Kr=187

dir=rslt_T2HKK_C_${FV_Kr}kt_${POT}POT
./makedir.sh $dir 1

./MH_analysis.sh T2HKK_C_MH_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_C_MH_${FV_Kr}kt_${POT}POT $dir/MH
./chi2-CP_analysis.sh T2HKK_C_chi2-CP_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_C_chi2-CP_${FV_Kr}kt_${POT}POT $dir/chi2-CP
./chi2-th23_analysis.sh T2HKK_C_chi2-th23_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_C_chi2-th23_${FV_Kr}kt_${POT}POT $dir/chi2-th23

####### site H
#POT=2.7 # * 10^21
iKr=1
KL=1090
OAB_Kr=1.3
rho_Kr=2.9
FV_HK=187
FV_Kr=187

dir=rslt_T2HKK_H_${FV_Kr}kt_${POT}POT
./makedir.sh $dir 1

./MH_analysis.sh T2HKK_H_MH_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_H_MH_${FV_Kr}kt_${POT}POT $dir/MH
./chi2-CP_analysis.sh T2HKK_H_chi2-CP_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_H_chi2-CP_${FV_Kr}kt_${POT}POT $dir/chi2-CP
./chi2-th23_analysis.sh T2HKK_H_chi2-th23_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_H_chi2-th23_${FV_Kr}kt_${POT}POT $dir/chi2-th23

####### HK*2
iKr=0
FV_HK=374
#POT=2.7 # * 10^21

# dummy inputs
KL=295
OAB_Kr=2.5
FV_Kr=187
rho_Kr=2.6

dir=rslt_T2HKK_HK_${FV_HK}kt_${POT}POT
./makedir.sh $dir 1

./MH_analysis.sh T2HKK_HK_MH_${FV_HK}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_HK_MH_${FV_HK}kt_${POT}POT $dir/MH
./chi2-CP_analysis.sh T2HKK_HK_chi2-CP_${FV_HK}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_HK_chi2-CP_${FV_HK}kt_${POT}POT $dir/chi2-CP
./chi2-th23_analysis.sh T2HKK_HK_chi2-th23_${FV_HK}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_HK_chi2-th23_${FV_HK}kt_${POT}POT $dir/chi2-th23