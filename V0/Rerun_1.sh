#!/bin/bash

#Jill Moore
#January 2018
#Weng Lab


#This pipeline is designed to run on UMass GHPCC (LSF Queue)
#Scripts which can be run individually are available upon request

###

id=$1
num=$2
pop=$3

scriptDir=~/Projects/GWAS/VIPER


file=/home/moorej3/Lab/ENCODE/Encyclopedia/V4/GWAS/$id/*.MAF.TSS.bed
sbatch --nodes 1 --array=$num --mem=1G --time=00:30:00 \
    --output=/home/moorej3/Job-Logs/jobid_%A_%a.output \
    --error=/home/moorej3/Job-Logs/jobid_%A_%a.error \
    $scriptDir/Match-MAF-TSS.sh $file $id $pop
