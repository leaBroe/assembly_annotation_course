#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=05:00:00
#SBATCH --job-name=kmercount
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/02-kmercount_%j.o
#SBATCH --error=/data/users/lbroennimann/02-kmercount_%j.e
#SBATCH --partition=pall

module load UHTS/Analysis/jellyfish/2.3.0

WORKDIR="/data/users/lbroennimann/assembly_annotation_course"
READ_DIR="/data/users/lbroennimann/assembly_annotation_course/participant_3"
OUTPUT_DIR="/data/users/jackermann/assembly_annotation_course/read_QC/kmer_counting"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to perform k-mer counting and histo generation
run_kmer_counting() {
  INPUT_DIR="$1"
  OUTPUT_PREFIX="$2"
  
  FILES=("$INPUT_DIR"/*.fastq.gz)
  
  for FILE in "${FILES[@]}"; do
    FILENAME=$(basename "$FILE")
    SAMPLENAME="${FILENAME%%.*}"
    OUTPUT_FILE="${OUTPUT_PREFIX}_${SAMPLENAME}.jf"
    
    jellyfish count -C -m 19 -s 5G -t 4 -o "$OUTPUT_FILE" <(zcat "$FILE")
  done
}

# Illumina
illumina_input_dir="${READ_DIR}/Illumina"
illumina_output_prefix="${OUTPUT_DIR}/ill_reads"
run_kmer_counting "$illumina_input_dir" "$illumina_output_prefix"

# PacBio
pacbio_input_dir="${READ_DIR}/pacbio" # Update the directory path accordingly
pacbio_output_prefix="${OUTPUT_DIR}/pacbio_reads"
run_kmer_counting "$pacbio_input_dir" "$pacbio_output_prefix"

# RNAseq
rnaseq_input_dir="${READ_DIR}/RNAseq" # Update the directory path accordingly
rnaseq_output_prefix="${OUTPUT_DIR}/rnaseq_reads"
run_kmer_counting "$rnaseq_input_dir" "$rnaseq_output_prefix"

# run jellyfish histo 
jellyfish histo -t 10 ill_reads.jf > ill_reads.histo
jellyfish histo -t 10 pacbio_reads.jf > pacbio_reads.histo
jellyfish histo -t 10 rnaseq_reads.jf > rnaseq_reads.histo
