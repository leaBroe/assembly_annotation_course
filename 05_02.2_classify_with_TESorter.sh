#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=TEsorter
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/logs/output_TEsort_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/logs/error_TEsort_%j.e
#SBATCH --partition=pall

# run this script 4 times

#extracted_sequences_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/copia_gypsy_seq/extracted_seq
#output_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter

# Brassicaceae TE DB
extracted_sequences_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/copia_gypsy_seq/brassicaceae_DB
output_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter/brassicaceae_TEsorter

mkdir ${output_dir}

#name=Gypsy
name=Copia

#Define other dictionaries that are used
    COURSEDIR=/data/courses/assembly-annotation-course


#input_file=${extracted_sequences_dir}/Gypsy.fa
input_file=${extracted_sequences_dir}/Copia.fa

#Go to folder where results should be stored.
    cd ${output_dir}

#Run  to ; do not indent
singularity exec \
--bind ${COURSEDIR} \
--bind ${extracted_sequences_dir} \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter ${input_file} -db rexdb-plant -pre ${name}