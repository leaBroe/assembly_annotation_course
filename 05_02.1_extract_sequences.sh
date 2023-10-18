#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:01:00
#SBATCH --job-name=extract_seq
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/copia_gypsy_seq/logs/output_seq_extract_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/copia_gypsy_seq/logs/error_seq_extract_%j.e
#SBATCH --partition=pall

# run this script 4 times

#sequence_dir=/data/users/srasch/assembly_course/05_annotation
#output_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/copia_gypsy_seq/extracted_seq

# Brassicaceae DB
sequence_dir=/data/courses/assembly-annotation-course/CDS_annotation
output_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/copia_gypsy_seq/brassicaceae_DB

mkdir ${output_dir}

# grep -A1 "Gypsy" ${sequence_dir}/polished.fasta.mod.EDTA.TElib.fa | grep -v -- "^--$" > ${output_dir}/Gypsy.fa
# grep -A1 "Copia" ${sequence_dir}/polished.fasta.mod.EDTA.TElib.fa | grep -v -- "^--$" > ${output_dir}/Copia.fa

#grep -A1 "Gypsy" ${sequence_dir}/Brassicaceae_repbase_all_march2019.fasta | grep -v -- "^--$" > ${output_dir}/Gypsy.fa
grep -A1 "Copia" ${sequence_dir}/Brassicaceae_repbase_all_march2019.fasta | grep -v -- "^--$" > ${output_dir}/Copia.fa
