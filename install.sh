#!/bin/bash

maindir=`pwd`
echo $maindir > maindir.txt
echo $maindir/beam_neu_v1 > beam_neu_dir.txt
echo none > job_system.txt

cd beam_neu_v1
./makelibs.sh