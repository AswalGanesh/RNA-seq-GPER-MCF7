#!/bin/bash
# 04_quantification.sh

#Quantification 
#Generates the raw gene-level count matrix from sorted BAM files using featureCounts

conda activate rnaseq


featureCounts -p -T 8 -s 0 -t exon -g gene_id \
  -a Data/reference/hg38.ncbiRefSeq.gtf \
  -o Results/Counts/GSE188706_raw_count.txt \
  Results/Alignment/sorted_*.bam



multiqc Results/Counts/ -o Results/Counts/