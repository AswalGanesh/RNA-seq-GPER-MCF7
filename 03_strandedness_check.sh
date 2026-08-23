#!/bin/bash
# 03_strandedness_check.sh
#Verrifing the library is stranded or unstranded using RSeQC

# Strandedness check 
conda activate rnaseq
gtfToGenePred Data/reference/hg38.ncbiRefSeq.gtf Data/reference/hg38.genePred
genePredToBed Data/reference/hg38.genePred Data/reference/hg38_RefSeq.bed

infer_experiment.py -r Data/reference/hg38_RefSeq.bed -i Results/Alignment/sorted_SRR16930723.bam


# RESULT (this project): ~50/50 split confirmed UNSTRANDED library.
#This is PairEnd Data
#Fraction of reads failed to determine: 0.0532
#Fraction of reads explained by "1++,1--,2+-,2-+": 0.4742
#Fraction of reads explained by "1+-,1-+,2++,2--": 0.4726