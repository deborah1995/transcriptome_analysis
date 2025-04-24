#!/bin/bash

# Paths to files
GTF_FILE="/home/bastoni/hg38_index/Homo_sapiens.GRCh38.113.gtf"
GENE_ANNOT_FILE="results_rna/gene_id_to_name.tsv"  # Path to output annotation file

# Create the file with headers
echo -e "Gene_ID\tGene_Name\tGene_Biotype" > $GENE_ANNOT_FILE

# Extract gene information from GTF
awk 'BEGIN {FS="\t"} $3 == "gene" { 
  split($9, a, ";"); 
  for(i in a) { 
    if(a[i] ~ /gene_id/) { 
      split(a[i], b, "\""); gene_id=b[2]; 
    } 
    if(a[i] ~ /gene_name/) { 
      split(a[i], c, "\""); gene_name=c[2]; 
    } 
  } 
  gene_biotype="protein_coding"; # Default biotype
  print gene_id"\t"gene_name"\t"gene_biotype
}' $GTF_FILE >> $GENE_ANNOT_FILE
