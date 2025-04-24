#!/bin/bash

echo "[03 - Gene ID to Name] Started at $(date)"

GTF=~/hg38_index/Homo_sapiens.GRCh38.113.gtf
MAP=results_rna/annotated/gene_id_to_name.tsv
INPUT_DIR=results_rna/counts
OUT_DIR=results_rna/annotated

mkdir -p $OUT_DIR

# Step 1: Extract gene_id to gene_name mapping
awk '$0 ~ /gene_id/ && $0 ~ /gene_name/ {
    match($0, /gene_id "[^"]+"/); gid=substr($0, RSTART+9, RLENGTH-10);
    match($0, /gene_name "[^"]+"/); gname=substr($0, RSTART+11, RLENGTH-12);
    print gid "\t" gname
}' $GTF | sort -u > $MAP

# Step 2: Annotate all *_ReadsPerGene.out.tab files
for file in $INPUT_DIR/*_ReadsPerGene.out.tab; do
    base=$(basename $file _ReadsPerGene.out.tab)
    output=$OUT_DIR/${base}_ReadsPerGene.out_with_names.tsv

    join -t $'\t' -1 1 -2 1 <(sort -k1,1 $file) <(sort -k1,1 $MAP) | \
        awk -F'\t' 'BEGIN{OFS="\t"} {print $1, $NF, $2, $3, $4}' > $output
done

echo "[03 - Gene ID to Name] Done at $(date)"
