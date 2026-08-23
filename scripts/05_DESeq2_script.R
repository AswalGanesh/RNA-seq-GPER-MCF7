library(DESeq2)

#1. Set working diractory 
setwd("D:/Project/RNA_Seq/Results/Counts")

# 2. Load the featureCounts output matrix
# We skip the first line because it contains the command header from featureCounts
counts_data = read.table("GSE188706_raw_count.txt", 
                          header=TRUE, row.names=1, sep="\t", skip=1)

# 3. Keep only the columns containing your 9 sample counts (Columns 6 onwards)
# Columns 1-5 contain chromosome, start, end, strand, and gene length info.
count_matrix = as.matrix(counts_data[, 6:ncol(counts_data)])

# 4. Create the experimental metadata table
# Adjust the names in condition if your order of samples differs
sample_info = data.frame(
  row.names = colnames(count_matrix),
  condition = factor(c("Control", "Control", "Control", 
                       "G1_100nM", "G1_100nM", "G1_100nM", 
                       "G1_1uM", "G1_1uM", "G1_1uM"))
)

# Crucial: Set the baseline group to Control so fold changes show up as "Treated vs Control"
sample_info$condition = relevel(sample_info$condition, ref = "Control")
View(sample_info)
View(count_matrix)
# 5. Create the DESeq2 object
dds = DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = sample_info,
                              design = ~ condition)

# 6. Filter out low-count genes (keeps genes with at least 10 total reads across all samples)
keep = rowSums(counts(dds)) >= 10
dds = dds[keep,]

# 7. Run the core DESeq2 analysis
dds = DESeq(dds)

# 8. Extract the results comparing High Dose (G1_1uM) vs Control
res_1uM = results(dds, contrast=c("condition", "G1_1uM", "Control"))
res_100nM = results(dds, contrast = c("condition", "G1_100nM", "Control"))
# Order the table so the most statistically significant genes show up at the top
res_1uM_ordered = res_1uM[order(res_1uM$padj), ]
res_100nM_ordered = res_100nM[order(res_100nM$padj), ]
# Save your final spreadsheet
write.csv(as.data.frame(res_1uM_ordered), "D:/Project/RNA_Seq/Results/tables/DGE_G1_1uM_vs_Control.csv")
write.csv(as.data.frame(res_100nM_ordered), "D:/Project/RNA_Seq/Results/tables/DGE_G1_100nM_vs_Control.csv")

# 9. View the top rows right inside RStudio
head(res_1uM_ordered, 5)

