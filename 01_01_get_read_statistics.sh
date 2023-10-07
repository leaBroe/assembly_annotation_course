#!/usr/bin/env bash

# Set environment variables and paths
WORKING_DIR="/data/users/lbroennimann/assembly_annotation_course"
OUTPUT_DIR="$WORKING_DIR/read_QC/fastqc"
LOG_DIR="$OUTPUT_DIR/logs"
PARTICIPANT_DIR="$WORKING_DIR/participant_3"
EMAIL=lea.broennimann@students.unibe.ch

# Create output and log directories if they don't exist
mkdir -p "$OUTPUT_DIR/illumina"
mkdir -p "$OUTPUT_DIR/pacbio"
mkdir -p "$OUTPUT_DIR/RNAseq"
mkdir -p "$LOG_DIR"

# Define output and error log file paths
OUTPUT_LOG="$LOG_DIR/output_fastqc_%j.o"
ERROR_LOG="$LOG_DIR/error_fastqc_%j.e"

# SBATCH parameters for job
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=03:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=$EMAIL
#SBATCH --mail-type=begin,end
#SBATCH --output=$OUTPUT_LOG
#SBATCH --error=$ERROR_LOG
#SBATCH --partition=pall

# Load FastQC module
module load UHTS/Quality_control/fastqc/0.11.9

# Perform FastQC on Illumina files
cd "$PARTICIPANT_DIR/Illumina"
fastqc -o "$OUTPUT_DIR/illumina" *fastq.gz

# Perform FastQC on PacBio files
cd "$PARTICIPANT_DIR/pacbio"
fastqc -o "$OUTPUT_DIR/pacbio" *fastq.gz

# Perform FastQC on RNAseq files
cd "$PARTICIPANT_DIR/RNAseq"
fastqc -o "$OUTPUT_DIR/RNAseq" *fastq.gz





