# VESPA Pipeline

Version 0.0

Jill Moore

Moore Lab - UMass Chan

December 2024


### Step 0 - Retrieve SNPs and LD SNPs given GWAS study

	./0_Curate-GWAS-SNPs.sh Master-GWAS-List.txt

### Step 1 - Generate 100 control SNPs matched for TSS and MAF quantiles for each GWAS SNP

	./1_Generate-Control-SNPs.sh Master-GWAS-List.txt

### Step 2 - Retrieve LD SNPs for Control SNPs

	./2_Curate-Control-SNPs.sh Master-GWAS-List.txt

### Step 3 - Overlap and Extract cRE Z-scores

	./3_Calculate-Signal-Enrichment.sh Master-GWAS-List.txt Signal_Type

### Step 4 - Calculate P-value for Enrichment

	./4_Calculate-Significance.sh Master-GWAS-List.txt Signal_Type

