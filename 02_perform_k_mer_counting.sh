#!/usr/bin/env bash

# Set environment variables and paths
WORKDIR="/data/users/lbroennimann/assembly_annotation_course"
READ_DIR="$WORKDIR/participant_3"
OUTPUT_DIR="$WORKDIR/read_QC/kmer_counts"
LOG_DIR="$OUTPUT_DIR/logs"
EMAIL="lea.broennimann@students.unibe.ch"

# Create output and log directories if they don't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# SBATCH parameters for the job
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=05:00:00
#SBATCH --job-name=kmercount
#SBATCH --mail-user="$EMAIL"
#SBATCH --mail-type=BEGIN,END
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/read_QC/kmer_counts/logs/02-kmercount_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/read_QC/kmer_counts/logs/02-kmercount_%j.e"
#SBATCH --partition=pall

# Load Jellyfish module
module load UHTS/Analysis/jellyfish/2.3.0

# Perform k-mer counting on Illumina files
IN="$READ_DIR/Illumina"
OUT="$OUTPUT_DIR"

FILES=("$IN"/*.fastq.gz)
SEQS=("${FILES[@]}")

cd "$OUT"

# Run Jellyfish count and histo
jellyfish count -C -m 19 -s 5G -t 4 <(zcat "${SEQS[0]}") <(zcat "${SEQS[1]}") -o ill_reads.jf
#jellyfish histo -t 10 ill_reads.jf > ill_reads.histo

