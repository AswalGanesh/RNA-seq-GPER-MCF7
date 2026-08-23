#!/bin/bash
# 01_download_qc.sh
# Setting up the conda enviroment and downloading the data 

# 1. Create and activate a dedicated environment 

conda create -n rnaseq -c bioconda -c conda-forge sra-tools fastqc fastp hisat2 samtools subread rseqc ucsc-genepredtobed ucsc-gtftogenepred multiqc -y
conda activate rnaseq


mkdir Data Data/raw Data/reference Results  Results/QC Results/Trimmed Results/Alignment Results/Counts Results/figures scripts

cd Data/raw

# 2. Download raw FASTQ files using the SRA Toolkit 
# (we need the SRP/SRR run accession numbers from the SRA Run Selector for GSE188706)	

prefetch SRP345788 --progress
fasterq-dump --split-files SRR16930723  --progress
fasterq-dump --split-files SRR16930724  --progress
fasterq-dump --split-files SRR16930725  --progress
fasterq-dump --split-files SRR16930726  --progress
fasterq-dump --split-files SRR16930727  --progress
fasterq-dump --split-files SRR16930728  --progress
fasterq-dump --split-files SRR16930729  --progress
fasterq-dump --split-files SRR16930730  --progress
fasterq-dump --split-files SRR16930731  --progress

cd -

fastqc Data/raw/*.fastq -o Results/QC

multiqc Results/QC -o Results/QC