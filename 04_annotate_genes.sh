#!/bin/bash

echo "[03 - Gene ID to Name] Started at $(date)"

# Path to the annotation file and counts directory
GENE_ANNOT_FILE="results_rna/gene_id_to_name.tsv"
COUNTS_DIR="results_rna/counts/"  # Directory with the counts files

# Annotating each *_ReadsPerGene.out.tab file
for FILE in $COUNTS_DIR/*_ReadsPerGene.out.tab; do
  OUTPUT_FILE="${FILE%.tab}_annotated.tsv"
  echo "[03 - Gene ID to Name] Annotating $FILE"

  # Add annotations from gene_id_to_name.tsv to counts file
  awk 'NR==FNR{a[$1]=$0; next} $1 in a{print $0"\t"a[$1]}' $GENE_ANNOT_FILE $FILE > $OUTPUT_FILE
done

echo "[03 - Gene ID to Name] Done at $(date)"
