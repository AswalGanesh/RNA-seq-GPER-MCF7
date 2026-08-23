#!/bin/bash
# 02_alignment.sh
# Downloads the hg38 reference genome + GTF annotation, builds the HISAT2 index


##Downloading reference data (analysis set of human genome and gtf file )
#analysis set 
conda activate rnaseq
cd Data/reference
wget -c https://hgdownload.gi.ucsc.edu/goldenPath/hg38/bigZips/analysisSet/hg38.analysisSet.fa.gz

#Downloading gtf file 
wget -c https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ncbiRefSeq.gtf.gz

#unzip file 
gunzip *.gz



# Build the HISAT2 Genome Index
hisat2-build -p 8 hg38.analysisSet.fa hg38_index  

cd -

#Alignment 


echo "Starting Sample 1/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930723_1.fastq -2 Data/raw/SRR16930723_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930723.bam
echo "Starting Sample 2/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930724_1.fastq -2 Data/raw/SRR16930724_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930724.bam
echo "Starting Sample 3/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930725_1.fastq -2 Data/raw/SRR16930725_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930725.bam
echo "Starting Sample 4/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930726_1.fastq -2 Data/raw/SRR16930726_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930726.bam
echo "Starting Sample 5/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930727_1.fastq -2 Data/raw/SRR16930727_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930727.bam
echo "Starting Sample 6/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930728_1.fastq -2 Data/raw/SRR16930728_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930728.bam
echo "Starting Sample 7/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930729_1.fastq -2 Data/raw/SRR16930729_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930729.bam
echo "Starting Sample 8/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930730_1.fastq -2 Data/raw/SRR16930730_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930730.bam
echo "Starting Sample 9/9..."
hisat2 -p 8 -x Data/reference/hg38_index -1 Data/raw/SRR16930731_1.fastq -2 Data/raw/SRR16930731_2.fastq | samtools view -@ 4 -bS - > Results/Alignment/SRR16930731.bam
echo "ALL 9 SAMPLES ALIGNED SUCCESSFULLY!"

#sorting 

echo "Starting Sample 1/9..."
samtools sort -@ 8 Results/Alignment/SRR16930723.bam > Results/Alignment/sorted_SRR16930723.bam
echo "Starting Sample 2/9..."
samtools sort -@ 8 Results/Alignment/SRR16930724.bam > Results/Alignment/sorted_SRR16930724.bam
echo "Starting Sample 3/9..."
samtools sort -@ 8 Results/Alignment/SRR16930725.bam > Results/Alignment/sorted_SRR16930725.bam
echo "Starting Sample 4/9..."
samtools sort -@ 8 Results/Alignment/SRR16930726.bam > Results/Alignment/sorted_SRR16930726.bam
echo "Starting Sample 5/9..."
samtools sort -@ 8 Results/Alignment/SRR16930727.bam > Results/Alignment/sorted_SRR16930727.bam
echo "Starting Sample 6/9..."
samtools sort -@ 8 Results/Alignment/SRR16930728.bam > Results/Alignment/sorted_SRR16930728.bam
echo "Starting Sample 7/9..."
samtools sort -@ 8 Results/Alignment/SRR16930729.bam > Results/Alignment/sorted_SRR16930729.bam
echo "Starting Sample 8/9..."
samtools sort -@ 8 Results/Alignment/SRR16930730.bam > Results/Alignment/sorted_SRR16930730.bam
echo "Starting Sample 9/9..."
samtools sort -@ 8 Results/Alignment/SRR16930731.bam > Results/Alignment/sorted_SRR16930731.bam
echo "ALL 9 SAMPLES sorted SUCCESSFULLY!"

#indexing 
echo "Starting Sample 1/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930723.bam
echo "Starting Sample 2/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930724.bam
echo "Starting Sample 3/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930725.bam
echo "Starting Sample 4/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930726.bam
echo "Starting Sample 5/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930727.bam
echo "Starting Sample 6/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930728.bam
echo "Starting Sample 7/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930729.bam
echo "Starting Sample 8/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930730.bam
echo "Starting Sample 9/9..."
samtools index -@ 8 Results/Alignment/sorted_SRR16930731.bam
echo "ALL Index created"
