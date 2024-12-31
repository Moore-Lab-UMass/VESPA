#!/bin/bash

list=$1
q=$(wc -l $list | awk '{print $1}')
rm -f running.bed
for j in `seq 1 1 $q`
do
    echo $j
    author=$(awk -F "\t" '{if (NR == '$j') print $3}' $list)
    pmid=$(awk -F "\t" '{if (NR == '$j') print $2}' $list)
    pheno=$(awk -F "\t" '{if (NR == '$j') print $1}' $list)
    id=$(awk -F "\t" '{if (NR == '$j') print $3"-"$2"-"$4}' $list)
    awk -v pheno="$pheno" '{print $0 "\t" pheno "\t" "'$author'" "\t" \
        "'$pmid'" "\t" "'$id'"}' $id/$pmid.bed >> running.bed
done
