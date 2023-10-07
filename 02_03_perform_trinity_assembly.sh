#!/bin/bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=trinity_assembly
#SBATCH --partition=pall
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/assembly/trinity/logs/05-trinity_assembly_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/assembly/trinity/logs/05-trinity_assembly_%j.e


module load UHTS/Assembler/trinityrnaseq/2.5.1;


WORKDIR="/data/users/lbroennimann/assembly_annotation_course"
READ_DIR="/data/users/lbroennimann/assembly_annotation_course/participant_3"
OUTPUT_DIR="/data/users/lbroennimann/assembly_annotation_course/assembly"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to perform Trinity assembly
run_trinity_assembly() {
  INPUT_DIR="$1"
  OUTPUT_DIR="$2"
  
  FILES=("$INPUT_DIR"/*.fastq.gz)
  
  for FILE in "${FILES[@]}"; do
    # Assuming single-end reads for Trinity
    FILENAME=$(basename "$FILE")
    SAMPLENAME="${FILENAME%%.*}"
    
    OUTPUT_SUBDIR="${OUTPUT_DIR}/${SAMPLENAME}_trinity_assembly"  # Ensure 'trinity' in the directory name
    
    # Create the output subdirectory if it doesn't exist
    mkdir -p "$OUTPUT_SUBDIR"
    
    # Run Trinity assembly for the current file
    Trinity \
      --seqType fq \
      --single "$FILE" \
      --CPU 12 \
      --max_memory 48G \
      --output "$OUTPUT_SUBDIR"
  done
}

# RNAseq data
rna_input_dir="${READ_DIR}/RNAseq" 
rna_output_dir="${OUTPUT_DIR}/RNAseq_assemblies"
run_trinity_assembly "$rna_input_dir" "$rna_output_dir"