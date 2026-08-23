###VOLCANO PLOT 
# 1. Load required libraries
library(ggplot2)
library(dplyr)

# 2. Set working directory & read dataset
setwd("D:/Project/RNA_Seq/Results/Counts")
df <- read.csv("DGE_G1_1uM_vs_Control.csv")

# 3. Preprocess & create Expression categories
df_clean <- df %>%
  filter(!is.na(log2FoldChange) & !is.na(padj)) %>%
  mutate(
    neg_log10_padj = -log10(padj),
    # Define Expression categories
    Expression = case_when(
      log2FoldChange > 1 & padj <= 0.05 ~ "Upregulated",
      log2FoldChange < -1 & padj <= 0.05 ~ "Downregulated",
      TRUE ~ "Not Significant"
    )
  )

# 4. Generate Volcano Plot with Custom Colors
ggplot(df_clean, aes(x = log2FoldChange, y = neg_log10_padj, color = Expression)) +
  
  # Add points mapped to Expression category
  geom_point(alpha = 0.6, size = 1.5) +
  
  # Set specific colors: Red (Up), Green (Down), Grey (Not Significant)
  scale_color_manual(values = c(
    "Upregulated"     = "red",
    "Downregulated"   = "green3",
    "Not Significant" = "grey50"
  )) +
  
  # Threshold cutoff lines
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black", linewidth = 0.6) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black", linewidth = 0.6) +
  
  # Labels and Limits
  labs(
    title = "Volcano Plot: G1 1uM vs Control (padj)",
    x = "log2 Fold Change",
    y = "-log10 (padj)"
  ) +
  #ylim(-0.2, 5) +
  
  # Theme
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 13),
    axis.title = element_text(size = 11),
    legend.position = "right"
  )
ggsave("D:/Project/RNA_Seq/Results/figures/volcano_1uM_vs_control.png", width = 8, height = 6, dpi = 300)

