#!/bin/bash

outdir=$1
mode=$2 #0:keep existing dir 1:delete existing dir

if [ -e $outdir ];then
    if [ $mode -eq 1 ];then
	rm -rf $outdir/*
    fi
else
	mkdir $outdir
fi