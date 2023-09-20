#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=03:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/output_error/output_fastqc_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/output_error/error_fastqc_%j.e
#SBATCH --partition=pall


cd /data/users/lbroennimann/assembly_annotation_course

# load fastqc module
module load UHTS/Quality_control/fastqc/0.11.9;

# define and change to directory where the fastq files are
#READS_DIR = /data/users/lbroennimann/assembly_annotation_course/participant_3


# fastqc on illumina files
cd /data/users/lbroennimann/assembly_annotation_course/participant_3/Illumina
mkdir /data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/illumina
fastqc -o /data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/illumina *fastq.gz

# fastqc on pacbio files
cd /data/users/lbroennimann/assembly_annotation_course/participant_3/pacbio
mkdir /data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/pacbio
fastqc -o /data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/pacbio *fastq.gz

# fastqc on RNAseq files
cd /data/users/lbroennimann/assembly_annotation_course/participant_3/RNAseq
mkdir /data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/RNAseq
fastqc -o /data/users/lbroennimann/assembly_annotation_course/read_QC/fastqc/RNAseq *fastq.gz





