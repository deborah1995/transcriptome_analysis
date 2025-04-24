#!/bin/bash

# Directories
INPUT_DIR="results_rna/trimmed"
OUTPUT_DIR="results_rna/aligned"
LOG_DIR="logs"
STAR_INDEX="/home/bastoni/hg38_index/star"
GENOME_DIR="$STAR_INDEX"

mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# STAR alignment
for fq in $INPUT_DIR/*_trimmed.fastq.gz; do
    SAMPLE=$(basename "$fq" _trimmed.fastq.gz)
    echo "[02 - STAR] Aligning $SAMPLE at $(date)" | tee -a "$LOG_DIR/02_star_align.log"

    STAR \
        --genomeDir "$GENOME_DIR" \
        --readFilesIn "$fq" \
        --readFilesCommand zcat \
        --runThreadN 4 \
        --outSAMtype BAM SortedByCoordinate \
        --outFileNamePrefix "$OUTPUT_DIR/${SAMPLE}_" \
        --outSAMunmapped Within \
        --outSAMattributes Standard \
        --quantMode GeneCounts \
        >> "$LOG_DIR/02_star_align.log" 2>&1

echo "[02 - STAR] Done with $SAMPLE at $(date)" | tee -a "$LOG_DIR/02_star_align.log"
done
