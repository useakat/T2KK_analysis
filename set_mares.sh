#!/bin/bash
maindir=`cat maindir.txt`
bindir=`cat beam_neu_dir.txt`

mares=$1
if [ $mares -eq 1100 ];then
    xsec=xsecNC_def
else
    xsec=xsecNC_mares$mares
fi
cd $bindir
./set_xsec.sh $xsec
cd $maindir
