#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`

mares=$1
if [ $mares -eq 1100 ];then
    xsecNC=xsecNC_def
else
    xsecNC=xsecNC_mares$mares
fi
cd $bindir
./set_xsec.sh 0 $xsecNC
cd $maindir
