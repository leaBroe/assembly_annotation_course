#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=04:00:00
#SBATCH --job-name=kmer_counting
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/k_mer_counts/output_error/output_jellyfish_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/k_mer_counts/output_error/error_jellyfish_%j.e
#SBATCH --partition=pall

module add UHTS/Analysis/jellyfish/2.3.0

# k-mer = 14

#jellyfish count -C -m 14 -s 1000000000 -t 10 *.fastq -o reads.jf

cd /data/users/lbroennimann/assembly_annotation_course/participant_3/Illumina

jellyfish count -C -m 14 -s 5G -t 4 <(zcat *.fastq.gz) -o reads.jf

