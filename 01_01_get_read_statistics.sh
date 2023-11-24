#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=03:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/logs/output_fastqc_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/logs/error_fastqc_%j.e
#SBATCH --partition=pall

# Usage: This script performs quality control checks using FastQC on fasta sequencing data.

# Configuration
WORKING_DIR=/data/users/lbroennimann/assembly_annotation_course
OUTPUT_DIR=${WORKING_DIR}/read_QC/fastqc
PARTICIPANT_DIR=${WORKING_DIR}/participant_3

# Create output directories if they don't exist
mkdir -p "$OUTPUT_DIR/illumina" "$OUTPUT_DIR/pacbio" "$OUTPUT_DIR/RNAseq"

# Load FastQC module
module load UHTS/Quality_control/fastqc/0.11.9

# Function to perform FastQC
perform_fastqc() {
    local input_dir=$1
    local output_dir=$2
    local file_type=$3

    if [ ! -d "$input_dir" ]; then
        echo "Directory $input_dir not found. Skipping FastQC for $file_type files."
        return
    fi

    echo "Performing FastQC on $file_type files..."
    cd "$input_dir"
    fastqc -o "$output_dir" *fastq.gz
}

# Perform FastQC on different file types
perform_fastqc ${PARTICIPANT_DIR}/Illumina ${OUTPUT_DIR}/illumina "Illumina"
perform_fastqc ${PARTICIPANT_DIR}/pacbio ${OUTPUT_DIR}/pacbio "PacBio"
perform_fastqc ${PARTICIPANT_DIR}/RNAseq ${OUTPUT_DIR}/RNAseq "RNAseq"

echo "FastQC analysis completed."



