#!/bin/bash

outdir=$1
if [ -e $outdir ];then
    rm -rf $outdir/*
else
    mkdir $outdir
fi 