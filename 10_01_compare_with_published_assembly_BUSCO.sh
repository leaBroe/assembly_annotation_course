#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=BUSCO_evaluation
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/data_from_paper/output_BUSCO_evaluation_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/data_from_paper/error_BUSCO_evaluation_%j.e
#SBATCH --partition=pall

# Load required modules
module add UHTS/Analysis/busco/4.1.4

# Define variables
ASSEMBLY_NAME="assembly_from_paper"
BUSCO_DIR="/data/users/lbroennimann/assembly_annotation_course/data_from_paper/BUSCO"
ASSEMBLY_PATH="/data/users/lbroennimann/assembly_annotation_course/data_from_paper/C24.chr.all.v2.0.fasta" # C24 assembly from the paper
AUGUSTUS_CONFIG_PATH="/software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config"
BUSCO_LINEAGE="brassicales_odb10"
BUSCO_MODE="genome" # Change to 'transcriptome' for Trinity assembly
CPU_COUNT=8

# Create BUSCO directory for the assembly
mkdir -p "${BUSCO_DIR}/${ASSEMBLY_NAME}" || exit 1

# Change to the BUSCO directory
cd "${BUSCO_DIR}/${ASSEMBLY_NAME}" || exit 1

# Copy AUGUSTUS config directory to a writable location
cp -r "${AUGUSTUS_CONFIG_PATH}" ./augustus_config
export AUGUSTUS_CONFIG_PATH=$(pwd)/augustus_config

# Run BUSCO for assembly quality assessment
busco -i "${ASSEMBLY_PATH}" -l ${BUSCO_LINEAGE} -o "${ASSEMBLY_NAME}" -m ${BUSCO_MODE} --cpu ${CPU_COUNT} -f

# Clean up: Remove the AUGUSTUS config directory
rm -rf ./augustus_config


