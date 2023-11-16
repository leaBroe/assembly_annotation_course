#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=20:00:00
#SBATCH --job-name=GENESPACE
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/run_GENESPACE_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/run_GENESPACE_%j.e
#SBATCH --partition=pall

course_dir=/data/users/lbroennimann/assembly_annotation_course
genespace_image=${course_dir}/scripts/genespace_1.1.4.sif
genespace_script=${course_dir}/scripts/genespace.R

apptainer exec \
--bind ${course_dir} \
${genespace_image} Rscript ${genespace_script}