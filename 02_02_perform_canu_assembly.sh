#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --partition=pall
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/assembly/canu/logs/03-canu_assembly_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/assembly/canu/logs/03-canu_assembly_%j.e

# Canu configuration
#maxThreads=16
#maxMemory=64
#gridEngineResourceOption="--cpus-per-task=$maxThreads --mem-per-cpu=${maxMemory}G"
#gridOptions="--partition=pall --mail-user=lea.broennimann@students.unibe.ch"

module load UHTS/Assembler/canu/2.1.1;

WORKDIR="/data/users/lbroennimann/assembly_annotation_course"
READ_DIR="/data/users/lbroennimann/assembly_annotation_course/participant_3"
OUTPUT_DIR="/data/users/lbroennimann/assembly_annotation_course/assembly/canu"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to perform Canu assembly
run_canu_assembly() {
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
    
    OUTPUT_SUBDIR="${OUTPUT_DIR}/${SAMPLENAME1}_${SAMPLENAME2}_canu"
    
    # Create the output subdirectory if it doesn't exist
    mkdir -p "$OUTPUT_SUBDIR"
    
    # Run Canu assembly for the current pair of files
    canu maxThreads=16 maxMemory=64 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" gridOptions="--partition=pall --mail-user=lea.broennimann@students.unibe.ch" -p "$SAMPLENAME1" genomeSize=133725193 -d "$OUTPUT_SUBDIR" -pacbio "$FILE1" "$FILE2"
  done
}

# PacBio
pacbio_input_dir="${READ_DIR}/pacbio" 
pacbio_output_dir="${OUTPUT_DIR}/pacbio_assemblies"
run_canu_assembly "$pacbio_input_dir" "$pacbio_output_dir"
