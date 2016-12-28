#!/bin/bash

date1=`date`
echo $date1

#ext=referee-chi2_test
#ext=sumdat_30points
ext=sumth_30points
params_card=params.card_new_50MeV
#params_card=params.card_new_50MeV_nosmear
#params_card=params.card_new_50MeV_nosmear_nofit
run_mode=1 # 0:serial run 1:parallel run
CPscan_div=8

###### MH
#./run_paper_plots_MH.sh $ext $params_card $run_mode $CPscan_div
    
###### MH-th23
#./run_paper_plots_MH-th23.sh $ext $params_card $run_mode $CPscan_div

###### CP sensitivity
#mail=0
#./run_paper_plots_CP.sh $ext $params_card $run_mode $mail

###### CP-chi2 plot
mail=0
./run_paper_plots_chi2-CP.sh $ext $params_card $run_mode $mail

rm -rf ~/.lsf/*