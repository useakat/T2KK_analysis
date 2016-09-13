#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`
date1=`date`
echo $date1

iMH=1 # switch for generating data for a Delta chi^2_min vs. delta_CP plot
ichi2_CP=0 # switch for generating data for a chi^2_min vs. delta_CP plot
ichi2_th23=0 # switch for generating data for a chi^2_min vs. th23 plot
iCP=0 # switch for CP sensitivity analysis
iCP_th23=0 # switch for CP-th23 plots
iCP_th13=0 # switch for CP-th13 contour plots
ith23_dmatm=0 # switch for CP-th13 contour plots
iCP_th13_oki=0 # switch for CP-th13 contour plots

rm -rf temp/params.card
mares=1100

#makedir.sh rslt_$run_name 1

if [ $iMH == 1 ]; then
### MH sensitivity study (nu vs anti-nu beam ratio)
#    run_name=T2HKK_H_MH_test
#    run_name=T2HKK_2.5_2.3_1040km_MH_noSK
#    run_name=T2HKK_2.5_2.3_1040km_MH_noKr_2SV
    run_name=T2HKK_2.5_2.3_1040km_MH
#    run_name=T2HKK_3.0_1000km_MH
#    run_name=T2HKK_3.0_H_MH_thatm-1_60
#    run_name=T2HKK_H_MH_kekcc
#    run_name=T2HKK_H_MH_icrr_test
#    run_name=parallel_test
#    run_name=CPscan_test_div16
#    run_name=parallel_test2
    ./makedir.sh rslt_$run_name 1

    # exp=1
    # L=653
    # OAB_SK=2.5
    # OAB_far=0.9

    exp=2
    OAB_SK=2.5
    L=1040
    OAB_far=2.3

## Setting parameter card
    params_card=params.card_new_50MeV
#    params_card=params.card_new_50MeV_nosmear
#    params_card=params.card_new_50MeV_nosmear_nofit
    cp -rf temp/$params_card temp/params.card 

    ./set_param_mode.sh 0 "iSK" 1
    ./set_param_mode.sh 0 "SV" 122.5
    ./set_param_mode.sh 0 "SL" 295
    ./set_param_mode.sh 0 "Srho" 2.6
    ./set_param_mode.sh 0 "SOAB" $OAB_SK

    ./set_param_mode.sh 0 "iOKi" 0
    ./set_param_mode.sh 0 "KV" 100
    ./set_param_mode.sh 0 "OL" 695
    ./set_param_mode.sh 0 "Orho" 2.75
    ./set_param_mode.sh 0 "OOAB" 0.9

    ./set_param_mode.sh 0 "iKr" 1
    ./set_param_mode.sh 0 "KV" 100
    ./set_param_mode.sh 0 "KL" $L
    ./set_param_mode.sh 0 "Krho" 2.9
    ./set_param_mode.sh 0 "KOAB" $OAB_far

    ./set_param_mode.sh 0 "Y" 5
    ./set_param_mode.sh 0 "ichi2_thatm" 0

    run_mode=1 # 0:serial run 1:parallel run
    CPscan_div=8
## Run
    MH=1 # True mass hierarcy choice 1:NH -1:IH
    # th23=0.6 # xa = -0.2
    # rm -rf par_*
    # ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 $run_mode $CPscan_div 0
    th23=0.5 # xa = -0.2
    rm -rf par_*
    ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 $run_mode $CPscan_div 1
    # th23=0.4 xa = -0.2
    # rm -rf par_*
    # ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 $run_mode $CPscan_div 1
    
    
    MH=-1 # True mass hierarcy choice 1:NH -1:IH
    # th23=0.6 # xa = -0.2
    # rm -rf par_*
    # ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 $run_mode $CPscan_div 0
    # th23=0.5 # xa = -0.2
    # rm -rf par_*
    # ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 $run_mode $CPscan_div 1
   #  th23=0.4 # xa = -0.2
   #  rm -rf par_*
   # ./MH_CP_th23_beam-ratio.sh $run_name $exp $L $OAB_SK $OAB_far $MH $th23 0 $run_mode $CPscan_div 1
fi


### CP sensitivity study 
# chi2-CP plot
if [ $ichi2_CP == 1 ]; then
    CPmode=CP
    fitMH=true

    exp=2
    L=1040
    OAB_SK=2.5
    OAB_far=2.3
    rho_SK=2.6
    rho_far=2.9

    # exp=3
    # L=295
    # OAB_SK=2.5
    # OAB_far=2.5
    # rho_SK=2.6
    # rho_far=2.6

#    run_name=t2kk_2.5_chi2-CP_nh_50MeV_40pt
#    run_name=t2hk_2.5_chi2-CP_nh_50MeV_40pt
#    run_name=t2kk_3.0_chi2-CP_nh_50MeV_40pt
#    run_name=T2HKK_2.5_chi2-CP_test
#    run_name=T2HKK_2.5_chi2-CP
#    run_name=T2HKK_3.0_0.5_1000km_chi2-CP
#    run_name=T2HKK_2.5_2.3_1040km_chi2-CP
    run_name=T2HKK_2.5_2.3_1040km_chi2-CP_noKr_2SV
#    run_name=test
    ./makedir.sh rslt_$run_name 1

#    params_card=params.card_new_50MeV_test
    params_card=params.card_new_50MeV
#    params_card=params.card_new_50MeV_nosmear
#    params_card=params.card_new_50MeV_nosmear_nofit
    cp -rf temp/$params_card temp/params.card 

#    ./set_param.sh "SV" 187
    ./set_param.sh "SV" 374
#    ./set_param.sh "SV" 122.5
    ./set_param.sh "iKr" 0
    ./set_param.sh "KV" 187

    ./set_param.sh "Y" 27

    ./set_param.sh "thatm" 0.5
    ./set_param.sh "fthatm" 0.5
    ./set_param.sh "err_thatm" 0.1

    MH=1
    CP=0
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
   cp -rf run.sh rslt_$run_name/.
    CP=90
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
   cp -rf run.sh rslt_$run_name/.
    CP=180
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
   cp -rf run.sh rslt_$run_name/.
    CP=270
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 1
   cp -rf run.sh rslt_$run_name/.

   MH=-1
    CP=0
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
   cp -rf run.sh rslt_$run_name/.
    CP=90
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
   cp -rf run.sh rslt_$run_name/.
    CP=180
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 0
   cp -rf run.sh rslt_$run_name/.
    CP=270
   ./chi2_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP 1
   cp -rf run.sh rslt_$run_name/.
fi

# chi2-th23 plot
# Please set the 4th argument of minimize_dchi2_2.sh to 4 (in X.sh)
if [ $ichi2_th23 == 1 ]; then
    CPmode=CP
    fitMH=true

    # exp=1
    # L=653
    # OAB_SK=2.5
    # OAB_far=0.9
    # rho_SK=2.6
    # rho_far=2.75

    exp=2
    L=1040
    OAB_SK=2.5
    OAB_far=2.3
    rho_SK=2.6
    rho_far=2.9

    # exp=3
    # L=295
    # OAB_SK=2.5
    # OAB_far=2.5
    # rho_SK=2.6
    # rho_far=2.6

#    run_name=t2ko_2.5_chi2-th23_nh_50MeV_20pt
#    run_name=t2ko_2.5_chi2-th23_ih_50MeV_20pt
#    run_name=t2kk_2.5_chi2-th23_nh_50MeV_20pt
#    run_name=t2kk_3.0_chi2-th23_nh_50MeV_20pt
#    run_name=t2hk_2.5_chi2-th23_nh_50MeV_20pt
#    run_name=t2hk_2.5_chi2-th23_ih_50MeV_20pt
#    run_name=T2HKK_2.5_chi2-th23_test
#    run_name=T2HKK_2.5_chi2-th23_CP90
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2mu_2
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2e_3
#    run_name=T2HKK_2.5_chi2-th23_mu2e
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2mu_noSK_nofitall_2
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2mu_noSK_nofitall_3
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2mu_noSK_nosysfit_nothatmpull
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2mu_noSK_nofit_fKfit_nothatmpull
#    run_name=T2HKK_2.5_chi2-th23_nosmear_5-0_mu2mu_noSK_nosysfit_fKfit_nothatmpull
#    run_name=T2HKK_2.5_chi2-th23_nosmear_1-1_mu2mu_nosysfit_fKfit_nothatmpull
#    run_name=T2HKK_2.5_chi2-th23_nosmear_1-1_nosysfit_fKfit_nothatmpull
#    run_name=T2HKK_2.5_chi2-th23_1-1_nothatmpull
#    run_name=T2HKK_2.5_chi2-th23_1-1
#    run_name=T2HKK_2.5_2.3_chi2-th23_1-1
    run_name=T2HKK_2.5_2.3_chi2-th23_1-1_noKr_2SV
    ./makedir.sh rslt_$run_name 1

    params_card=params.card_new_50MeV
#    params_card=params.card_new_50MeV_nosmear
#    params_card=params.card_new_50MeV_nosmear_nofit
    cp -rf temp/$params_card temp/params.card 

#    ./set_param.sh "SV" 122.5
#    ./set_param.sh "SV" 187
    ./set_param.sh "SV" 374
    ./set_param.sh "KV" 187

    ./set_param.sh "Y" 27

    CP=0
    ./set_param.sh "dCP" $CP
    ./set_param.sh "fdCP" $CP
#    ./set_param.sh "ichi2_thatm" 0
#    ./set_param.sh "ifit_dCP" 0
#    ./set_param.sh "ifit_s2sol_2" 0
#    ./set_param.sh "ifit_s2rct_2" 0
#    ./set_param.sh "ifit_dm21_2" 0
#    ./set_param.sh "ifit_dmatm_2" 0

    MH=1
    th23=0.6
    ./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
    cp -rf run.sh rslt_$run_name/.
    th23=0.5
    ./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
    cp -rf run.sh rslt_$run_name/.
     th23=0.4
     ./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 1
     cp -rf run.sh rslt_$run_name/.

    MH=-1
    th23=0.6
    ./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
    cp -rf run.sh rslt_$run_name/.
    th23=0.5
    ./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 0
    cp -rf run.sh rslt_$run_name/.
     th23=0.4
     ./chi2_th23_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $CP $th23 1
     cp -rf run.sh rslt_$run_name/.
fi

# CP-th23 plot
if [ $iCP_th23 == 1 ]; then
    CPmode=CP

    # exp=2
    # L=1000
    # OAB_SK=3.0
    # OAB_far=0.5
    # rho_SK=2.6
    # rho_far=3.0

    exp=3
    L=295
    OAB_SK=2.5
    OAB_far=2.5
    rho_SK=2.6
    rho_far=2.6

    fitMH=true
    MH=1
    th23=0.5
    CP=0

#    run_name=t2hk_2.5_CP-th23_nuY4.5
    run_name=test
    ./makedir.sh rslt_$run_name 1

    params_card=params.card_new_50MeV_elike
    cp -rf temp/$params_card temp/params.card 

    ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th23 $CP 1
    mv rslt_unit_out/* rslt_$run_name/.
#    ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th23 $CP 1
#    mv rslt_unit_out/* rslt_$run_name/.

    # run_name=t2hk_2.5_CP-th23_nuY3.5
    # mkdir rslt_$run_name
    # mv temp/params.card_new_year .
    # sed -e "s/ Y .*/ Y 3.5/" params.card_new_year > tmp.year
    # mv tmp.year temp/params.card_new_year
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th23 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th23 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # run_name=t2hk_2.5_CP-th23_nuY2.5
    # mkdir rslt_$run_name
    # mv temp/params.card_new_year .
    # sed -e "s/ Y .*/ Y 2.5/" params.card_new_year > tmp.year
    # mv tmp.year temp/params.card_new_year
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th23 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th23 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # run_name=t2hk_2.5_CP-th23_nuY1.5
    # mkdir rslt_$run_name
    # mv temp/params.card_new_year .
    # sed -e "s/ Y .*/ Y 1.5/" params.card_new_year > tmp.year
    # mv tmp.year temp/params.card_new_year
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th23 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th23 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # run_name=t2hk_2.5_CP-th23_nuY0.5
    # mkdir rslt_$run_name
    # mv temp/params.card_new_year .
    # sed -e "s/ Y .*/ Y 0.5/" params.card_new_year > tmp.year
    # mv tmp.year temp/params.card_new_year
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th23 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th23_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th23 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.
fi

# CP-th13 plot
if [ $iCP_th13 == 1 ]; then
    CPmode=CP

    # exp=2
    # L=1000
    # OAB_SK=3.0
    # OAB_far=0.5
    # rho_SK=2.6
    # rho_far=2.9

    exp=3
    L=295
    OAB_SK=2.5
    OAB_far=2.5
    rho_SK=2.6
    rho_far=2.6

    fitMH=true
    MH=1

    params_card=params.card_new_nosmear
    cp -rf temp/$params_card temp/params.card 

    run_name_head=t2hk_2.5_CP-th13_nuY
    th13=0.095

    run_name=test
    makedir.sh rslt_$run_name 1

    CP=0
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 4.5 0.5 $th13 $CP 1
    mv rslt_unit_out/* rslt_$run_name/.
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 3.5 1.5 $th13 $CP 1
    mv rslt_unit_out/* rslt_$run_name/.
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 2.5 2.5 $th13 $CP 1
    mv rslt_unit_out/* rslt_$run_name/.
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1.5 3.5 $th13 $CP 1
    mv rslt_unit_out/* rslt_$run_name/.
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0.5 4.5 $th13 $CP 1
    mv rslt_unit_out/* rslt_$run_name/.

    # nuY=4.5
    # run_name=$run_name_head$nuY
    # mkdir rslt_$run_name
    # mv temp/$params_card .
    # sed -e "s/ Y .*/ Y $nuY/" $params_card > tmp.year
    # mv tmp.year temp/$params_card
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th13 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th13 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # nuY=0.5
    # run_name=$run_name_head$nuY
    # mkdir rslt_$run_name
    # mv temp/$params_card .
    # sed -e "s/ Y .*/ Y $nuY/" $params_card > tmp.year
    # mv tmp.year temp/$params_card
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th13 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th13 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # nuY=3.5
    # run_name=$run_name_head$nuY
    # mkdir rslt_$run_name
    # mv temp/$params_card .
    # sed -e "s/ Y .*/ Y $nuY/" $params_card > tmp.year
    # mv tmp.year temp/$params_card
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th13 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th13 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # nuY=1.5
    # run_name=$run_name_head$nuY
    # mkdir rslt_$run_name
    # mv temp/$params_card .
    # sed -e "s/ Y .*/ Y $nuY/" $params_card > tmp.year
    # mv tmp.year temp/$params_card
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th13 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th13 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.

    # nuY=2.5
    # run_name=$run_name_head$nuY
    # mkdir rslt_$run_name
    # mv temp/$params_card .
    # sed -e "s/ Y .*/ Y $nuY/" $params_card > tmp.year
    # mv tmp.year temp/$params_card
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 0 $th13 $CP 0
    # mv rslt_unit_out/* rslt_$run_name/.
    # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 0 1 $th13 $CP 1
    # mv rslt_unit_out/* rslt_$run_name/.
fi

if [ $iCP_th13_oki == 1 ]; then
    CPmode=CP

    exp=1
    L=653
    OAB_SK=3.0
    OAB_far=1.4
    rho_SK=2.6
    rho_far=2.75

    # exp=2
    # L=1000
    # OAB_SK=3.0
    # OAB_far=0.5
    # rho_SK=2.6
    # rho_far=2.9

    # exp=3
    # L=295
    # OAB_SK=3.0
    # OAB_far=3.0
    # rho_SK=2.6
    # rho_far=2.6

    run_name=test
    makedir.sh rslt_$run_name 1

    params_card=params.card_new_50MeV
    cp -rf temp/$params_card temp/params.card 

    MH=1
    fitMH=true
    th13=0.04
    CP=0
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=90
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=180
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=270
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.

    th13=0.08
    CP=0
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=90
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=180
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=270
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.

    th13=0.12
    CP=0
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=90
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=180
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.
    CP=270
    ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
    mv rslt_unit_out/* rslt_$run_name/.

   #  fitMH=wrong
   #  th13=0.04
   #  CP=0
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=90
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=180
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=270
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.

   #  th13=0.08
   #  CP=0
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   # CP=90
   # ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   # mv rslt_unit_out/* rslt_$run_name/.
   #  CP=180
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=270
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.

   #  th13=0.12
   #  CP=0
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=90
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=180
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.
   #  CP=270
   #  ./th13_CP_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 1 $th13 $CP 0
   #  mv rslt_unit_out/* rslt_$run_name/.

fi

### CP sensitivity study
if [ $iCP == 1 ]; then
    CPmode=CP
    fitMH=true

    # exp=1
    # L=653
    # OAB_SK=2.5
    # OAB_far=0.9
    # rho_SK=2.6
    # rho_far=2.75

    exp=2
    L=1000
    OAB_SK=3.0
    OAB_far=0.5
    rho_SK=2.6
    rho_far=2.9
#    rho_SK=0
#    rho_far=0

    # exp=3
    # L=295
    # VV=560
    # OAB_SK=2.5
    # OAB_far=2.5
    # rho_SK=2.6
    # rho_far=2.6

#    Run_name=test_ih
#    run_name=t2kk_3.0_CP_nh_50MeV_40pt
#    run_name=t2kk_3.0_CP_nh_50MeV_40pt_test
#    run_name=t2kk_3.0_CP_nh_50MeV_40pt_test2
#    run_name=t2kk_3.0_CP_nh_50MeV_40pt_effmod
#    run_name=t2kk_3.0_CP_nh_50MeV_40pt_effmod_test2
    run_name=t2kk_3.0_CP_nh_50MeV_40pt_effmod2
#    run_name=t2kk_3.0_CP_ih_50MeV_40pt
#    run_name=t2kk_3.0_CP_nh_50MeV_40pt_10y
#    run_name=t2kk_2.5_CP_nh_50MeV_40pt
#    run_name=t2kk_2.5_CP_ih_50MeV_40pt
#    run_name=t2ko_2.5_CP_nh_50MeV_40pt
#    run_name=t2ko_2.5_CP_ih_50MeV_40pt
#    run_name=t2ko_2.5_CP_nh_50MeV_40pt_10y
#    run_name=t2hk_2.5_CP_nh_50MeV_40pt_10y_30gev_2
#    run_name=t2hk_2.5_CP_ih_50MeV_40pt
    ./makedir.sh rslt_$run_name 0

    MH=1
    YY=5

#    params_card=params.card_new_nosmear
    params_card=params.card_new_50MeV
#    params_card=params.card_new_50MeV_nonc
#    params_card=params.card_new_50MeV_test
    cp -rf temp/$params_card temp/params.card 

    th23=0.5
    sed -e "s/ thatm .*/ thatm  $th23/" \
	-e "s/ Y .*/ Y  $YY/" \
	-e "s/ OV .*/ OV  $VV/" \
	-e "s/ fthatm .*/ fthatm  $th23/" temp/params.card > params_card.tmp
    mv params_card.tmp temp/params.card
#    ./CP_CP_run_2.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 9 1 $th23 1
    # ./CP_CP_run_2.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 7 3 $th23 0
    ./CP_CP_run_2.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 3 7 $th23 1
    # ./CP_CP_run_2.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 3 7 $th23 0
    # ./CP_CP_run_2.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 1 9 $th23 1

fi

#./MH_pi0unc_dist_unit.sh 1 653 3 1.4 1 5 0 0.6 1
#./MH_pi0unc_dist_unit.sh 1 653 3 1.4 1 5 0 0.5 1
#./MH_pi0unc_dist_unit.sh 1 653 3 1.4 1 5 0 0.4 1
#./MH_pi0unc_dist_unit.sh 2 1000 3 0.5 1 5 0 0.5 1

#./MH_cohunc_all_input.sh mh_cohunc 1 2 1000 3 0.5 1 5 0 0.5

### MH sensitivity study
#./MH_CP-th23_all_input.sh test 1 2 1000 3 0.5 1 5 0
#./MH_CP-th23_all_input.sh mh_cp_2scan 1 2 1000 2.5 1.0 1 5 
#./MH_CP-th23_all_input.sh mh_cp.ss23_2scan 0 1 653 2.5 0.9 -1
#./MH_CP-th23_all_input.sh mh_cp.ss23_2scan 0 2 1000 2.5 1.0 1
#./MH_CP-th23_all_input.sh mh_cp.ss23_2scan 1 2 1000 2.5 1.0 -1


# CP-th23 plot
if [ $ith23_dmatm == 1 ]; then
    CPmode=CP

    exp=2
    L=1000
    OAB_SK=3.0
    OAB_far=0.5
    rho_SK=2.6
    rho_far=2.9

    # exp=3
    # L=295
    # OAB_SK=2.5
    # OAB_far=2.5
    # rho_SK=2.6
    # rho_far=2.6

    fitMH=true
    MH=1
    th23=0.6
    dmatm=0.00232

    run_name=t2kk_3.0_th23_dm32_nh_50MeV_15pt
#    run_name=test
    ./makedir.sh rslt_$run_name 1

#    params_card=params.card_new_nosmear
    params_card=params.card_new_50MeV
    cp -rf temp/$params_card temp/params.card 

    CP=0
    sed -e "s/ dCP .*/ dCP $CP/" \
	-e "s/ fdCP .*/ fdCP $CP/" temp/params.card > params_card.tmp
    mv params_card.tmp temp/params.card
    ./th23_dmatm_run.sh $run_name $CPmode $fitMH $exp $L $OAB_SK $OAB_far $rho_SK $rho_far $MH 5 5 $th23 $dmatm 1
    mv rslt_unit_out/* rslt_$run_name/.
fi

xsecCC_dir=`cat $bindir/xsecCC/xsecCC_dir.txt`
xsecNC_dir=`cat $bindir/xsecNC/xsecNC_dir.txt`
echo $xsecCC_dir > rslt_$run_name/xsec_dir.txt
echo $xsecNC_dir >> rslt_$run_name/xsec_dir.txt

cp -rf beam_neu_dir.txt rslt_$run_name/.

date2=`date`
echo ""
echo $date1
echo $date2