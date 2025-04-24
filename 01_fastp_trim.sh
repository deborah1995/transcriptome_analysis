#!/bin/bash

mkdir -p results_rna/trimmed
mkdir -p logs

echo "[01 - fastp] Started at $(date)" > logs/01_fastp_trim.nohup.log

for fq in ../trascrittoma/*.fastq.gz; do
    base=$(basename "$fq" .fastq.gz)
    echo "Processing $base" >> logs/01_fastp_trim.nohup.log

    fastp \
        -i $fq \
        -o results_rna/trimmed/${base}_trimmed.fastq.gz \
        --detect_adapter_for_pe \
        -w 4 \
        --html results_rna/trimmed/${base}_fastp.html \
        --json results_rna/trimmed/${base}_fastp.json \
        --report_title "$base trimming report" \
        >> logs/01_fastp_trim.nohup.log 2>&1
done

echo "[01 - fastp] Finished at $(date)" >> logs/01_fastp_trim.nohup.log
