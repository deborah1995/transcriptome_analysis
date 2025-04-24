# transcriptome_analysis

This repository contains scripts, methods, and outputs for the transcriptome analysis performed on four human liver biopsy RNA-seq samples.

### Overview

##### The analysis workflow includes the following main steps:

Quality control (QC): Assessment of raw reads using FastQC.

Trimming and Filtering: Removal of low-quality reads and adapters using Trimmomatic.

Alignment: Mapping reads to the reference genome using STAR.

Quantification: Gene expression quantification using featureCounts.

Differential Expression Analysis (DEA): Identification of differentially expressed genes using DESeq2.

Visualization: Principal Component Analysis (PCA) plots, heatmaps, and volcano plots.

##### Requirements

Tools and Software:

FastQC

Trimmomatic

STAR

featureCounts (Subread package)

DESeq2 (R/Bioconductor)

Reference Genome:

Homo sapiens (GRCh38/hg38)
