#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=05:00:00
#SBATCH --job-name=kmercount
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/02-kmercount_%j.o
#SBATCH --error=/data/users/lbroennimann/02-kmercount_%j.e
#SBATCH --partition=pall

module load UHTS/Analysis/jellyfish/2.3.0;

WORKDIR=/data/users/lbroennimann/assembly_annotation_course
READ_DIR=/data/users/lbroennimann/assembly_annotation_course/participant_3

mkdir /data/users/jackermann/assembly_annotation_course/read_QC/kmer_counting

# illumina
IN=${READ_DIR}/Illumina

FILES=`ls ${IN}/*.fastq.gz`
SEQS=($FILES)

OUT=${WORKDIR}/read_QC/kmer_counting/
cd $OUT

jellyfish count -C -m 21 -s 5G -t 4 <(zcat ${SEQS[1]}) <(zcat ${SEQS[2]}) -o ill_reads.jf
jellyfish histo -t 10 ill_reads.jf > ill_reads.histo
