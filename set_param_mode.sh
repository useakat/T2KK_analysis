#!/bin/bash

mode=$1  # 0:modify temp/params.card  1:modify ./params.card
param=$2
value=$3

if [ $mode -eq 0 ];then
    sed -e "s/ $param .*/ $param $value/" temp/params.card > params_card.tmp
    mv params_card.tmp temp/params.card
elif [ $mode -eq 1 ];then
    sed -e "s/ $param .*/ $param $value/" params.card > params_card.tmp
    mv params_card.tmp params.card
fi