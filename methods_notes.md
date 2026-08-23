# Methods Notes

Notes on the decisions I made during this analysis and why, so it's clear this wasn't just running default commands.

## Adapter trimming - why I skipped it

I checked the MultiQC report before deciding on this. Here's what it actually showed across all 18 files:

```
Check	                                          Result
Per-base sequence quality	                      18/18 pass
Per-sequence quality scores	                      18/18 pass
Per-base N content	                              18/18 pass
Sequence length distribution	                  18/18 pass
Per-sequence GC content	                          10 pass, 8 warn
Sequence duplication levels	                      18/18 warn
Adapter content                                   6 pass, 12 warn
```

Per-base quality was clean across every single file - no warnings, no fails. Adapter content showed a "warn" flag (not "fail") in 12 of the 18 files, so there was some adapter presence, just not severe.

Given that, I decided to skip a separate trimming step. HISAT2 does soft-clipping by default - it can align the clean part of a read and just clip off a contaminated end during alignment, instead of needing adapters removed beforehand. This handles mild contamination reasonably well. It's not exactly the same as trimming, so I'm noting this as a deliberate trade-off I made, not something I missed.

Sequence duplication showing "warn" in all 18 files is expected for RNA-seq (a few highly expressed genes naturally produce lots of identical reads) - not a sign of a technical problem.

## Strandedness check

The GEO metadata only said "standard library preparation," which wasn't specific enough to know if the library was stranded or not. I checked this using RSeQC's infer_experiment.py on one representative BAM file:

```
Fraction of reads explained by "1++,1--,2+-,2-+": 0.4742
Fraction of reads explained by "1+-,1-+,2++,2--": 0.4726
```

Close to a 50/50 split, which means the library is unstranded. I only checked one sample instead of all nine because strandedness comes from the library prep protocol, which is the same for every sample in the same study - it isn't something that varies sample to sample.

Because of this, I ran featureCounts with -s 0 (unstranded), which was the correct setting.

## Thresholds I used
- For calling a gene significant (used for DESeq2 results and GO enrichment): padj < 0.05 and |log2FoldChange| > 1
- For the STRING network plots specifically, I had to use a stricter cutoff (|log2FoldChange| > 2). The full significant gene list (800+ genes for downregulated) was too large for STRING to make a readable network. This stricter cutoff is only for that one figure - it's not a different significance rule, just a practical limit for making a plot you can actually read.

## 100 nM - no significant genes

At the 100 nM dose, no gene passed padj < 0.05 after correction, even though 262 genes had a raw p-value under 0.05 before correction. I double-checked this wasn't a bug by manually recalculating the FDR correction from the raw p-values myself, and it matched DESeq2's output exactly.

This doesn't mean 100 nM did nothing biologically - it means the effect at that dose was too small/inconsistent across only 3 replicates to survive correction across around 21,000 genes tested at once. Combined with the strong result at 1 uM, this points to the treatment needing to cross a dose threshold before it produces a response big enough to detect reliably. Because of this, I didn't run GO enrichment or STRING on the 100 nM results - I didn't want to build conclusions on top of a gene list that wasn't actually statistically supported.

## Low-count filtering

Before running DESeq2, I removed genes with fewer than 10 total reads across all 9 samples combined. This is standard practice - genes with very low counts don't have enough data to get a reliable result and just add noise.

## GO enrichment - sorting

When reading the GO enrichment plots, I sorted by -log10(FDR) instead of the default Fold Enrichment. Fold enrichment can look big for a term that's only based on 2-3 genes, which isn't a reliable result even if the ratio looks dramatic. Sorting by FDR instead puts the most statistically solid terms at the top, and I only trusted a term as a real finding if it also had a reasonable number of genes behind it, not just a high fold enrichment number.