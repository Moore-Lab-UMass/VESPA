#!/bin/bash

data=$1
type=$2
genome=$3

data=$1
type=$2
g1=$3
g2=$4
mode=$5

header=~/Lab/ENCODE/Encyclopedia/V5/GWAS/$type-Header-$g2.txt
dirControl=~/Lab/ENCODE/Encyclopedia/V5/GWAS/$data/Controls
dirGWAS=~/Lab/ENCODE/Encyclopedia/V5/GWAS/$data
scriptDir=~/Projects/GWAS/VIPER

mkdir -p /tmp/moorej3/$SLURM_JOBID
cd /tmp/moorej3/$SLURM_JOBID

paste $dirControl/Overlap*.$type.$g1.$g2.$mode.txt | \
    awk '{for(i=1;i<=NF;i+=2) t+=$i; print t; t=0}' > A
paste $dirControl/Overlap*.$type.$g1.$g2.$mode.txt | \
    awk '{for(i=2;i<=NF;i+=2) t+=$i; print t; t=0}' > B
paste A B > Control.Overlap.$type.$g1.$g2.$mode.txt


paste $header $dirGWAS/Overlap.$data.$type.$g1.$g2.$mode.txt \
    Control.Overlap.$type.$g1.$g2.$mode.txt > Results.$type.txt
python $scriptDir/fisher.test.py Results.$type.txt > test

awk '{print $6}' test > p
Rscript ~/Projects/ENCODE/Encyclopedia/Version4/GWAS-Analysis/fdr.R
paste test results.txt > Enrichment.$data.$type.$g1.$g2.$mode.FISHER.txt

mv Enrichment.$data.$type.$g1.$g2.$mode.FISHER.txt $dirGWAS

rm -r /tmp/moorej3/$SLURM_JOBID/
