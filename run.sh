#!/bin/bash

./set_params_card.sh

sed -e "s/scan_mode=0/scan_mode=1/" chi2_scan.sh > tmp.sh
#sed -e "s/scan_mode=1/scan_mode=0/" chi2_scan.sh > tmp.sh
mv tmp.sh chi2_scan.sh
chmod +x chi2_scan.sh

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

# ./MH_analysis.sh T2HKK_C_MH_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# mv rslt_T2HKK_C_MH_${FV_Kr}kt_${POT}POT $dir/MH
# ./chi2-CP_analysis.sh T2HKK_C_chi2-CP_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# mv rslt_T2HKK_C_chi2-CP_${FV_Kr}kt_${POT}POT $dir/chi2-CP
# ./chi2-th23_analysis.sh T2HKK_C_chi2-th23_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# mv rslt_T2HKK_C_chi2-th23_${FV_Kr}kt_${POT}POT $dir/chi2-th23

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

# ./MH_analysis.sh T2HKK_H_MH_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# mv rslt_T2HKK_H_MH_${FV_Kr}kt_${POT}POT $dir/MH
# ./chi2-CP_analysis.sh T2HKK_H_chi2-CP_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# mv rslt_T2HKK_H_chi2-CP_${FV_Kr}kt_${POT}POT $dir/chi2-CP
# ./chi2-th23_analysis.sh T2HKK_H_chi2-th23_${FV_Kr}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
# mv rslt_T2HKK_H_chi2-th23_${FV_Kr}kt_${POT}POT $dir/chi2-th23

####### HK*2
./set_param_mode.sh 0 "iSK" 1
./set_param_mode.sh 0 "SV" 22.5
./set_param_mode.sh 0 "SL" 295
./set_param_mode.sh 0 "Srho" 2.6
./set_param_mode.sh 0 "SOAB" 2.5

./set_param_mode.sh 0 "iOki" 1 # for HK1
./set_param_mode.sh 0 "OV" 187
./set_param_mode.sh 0 "OL" 295
./set_param_mode.sh 0 "Orho" 2.6
./set_param_mode.sh 0 "OOAB" 2.5

./set_param_mode.sh 0 "iKr" 1 # for HK2
./set_param_mode.sh 0 "KV" 187
./set_param_mode.sh 0 "KL" 295
./set_param_mode.sh 0 "Krho" 2.6
./set_param_mode.sh 0 "KOAB" 2.5

./set_param_mode.sh 0 "Y" $POT

FV_HK=374
iKr=1  # for HK2
KL=295
OAB_Kr=2.5
FV_Kr=187
rho_Kr=2.6

dir=rslt_T2HKK_HK_${FV_HK}kt_${POT}POT
./makedir.sh $dir 1

#./MH_analysis.sh T2HKK_HK_MH_${FV_HK}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
#mv rslt_T2HKK_HK_MH_${FV_HK}kt_${POT}POT $dir/MH
./chi2-CP_analysis.sh T2HKK_HK_chi2-CP_${FV_HK}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_HK_chi2-CP_${FV_HK}kt_${POT}POT $dir/chi2-CP
./chi2-th23_analysis.sh T2HKK_HK_chi2-th23_${FV_HK}kt_${POT}POT $iKr $KL $OAB_Kr $rho_Kr $FV_HK $FV_Kr $POT
mv rslt_T2HKK_HK_chi2-th23_${FV_HK}kt_${POT}POT $dir/chi2-th23