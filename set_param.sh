#!/bin/bash

param=$1
value=$2

sed -e "s/ $param .*/ $param $value/" temp/params.card > params_card.tmp
mv params_card.tmp temp/params.card