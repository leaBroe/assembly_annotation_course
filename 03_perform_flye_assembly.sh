#!/bin/bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye_assembly
#SBATCH --partition=pall
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/assembly/flye/logs/03-flye_assembly_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/assembly/flye/logs/03-flye_assembly_%j.e

module load UHTS/Assembler/flye/2.8.3;

WORKDIR="/data/users/lbroennimann/assembly_annotation_course"
READ_DIR="/data/users/lbroennimann/assembly_annotation_course/participant_3"
OUTPUT_DIR="/data/users/lbroennimann/assembly_annotation_course/assembly/flye"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to perform Flye assembly
run_flye_assembly() {
  INPUT_DIR="$1"
  OUTPUT_DIR="$2"
  
  FILES=("$INPUT_DIR"/*.fastq.gz)
  
  for ((i = 0; i < ${#FILES[@]}; i += 2)); do
    FILE1="${FILES[i]}"
    FILE2="${FILES[i + 1]}"
    
    FILENAME1=$(basename "$FILE1")
    FILENAME2=$(basename "$FILE2")
    
    SAMPLENAME1="${FILENAME1%%.*}"
    SAMPLENAME2="${FILENAME2%%.*}"
    
    OUTPUT_SUBDIR="${OUTPUT_DIR}/${SAMPLENAME1}_${SAMPLENAME2}_assembly"
    
    # Create the output subdirectory if it doesn't exist
    mkdir -p "$OUTPUT_SUBDIR"
    
    # Run Flye assembly for the current pair of files
    flye --threads 16 --genome-size 133725193 --out-dir "$OUTPUT_SUBDIR" --pacbio-raw "$FILE1" "$FILE2"
  done
}

# PacBio
pacbio_input_dir="${READ_DIR}/pacbio" 
pacbio_output_dir="${OUTPUT_DIR}/pacbio_assemblies"
run_flye_assembly "$pacbio_input_dir" "$pacbio_output_dir"

