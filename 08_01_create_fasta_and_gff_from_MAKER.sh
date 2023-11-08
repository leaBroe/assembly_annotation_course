#!/usr/bin/env bash

#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --partition=pall

#SBATCH --time=2-20:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16

#SBATCH --job-name=maker
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/7_create_fasta_gff_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/7_create_fasta_gff_%j.e

module load SequenceAnalysis/GenePrediction/maker/2.31.9;

export TMPDIR=$SCRATCH

working_dir=/data/users/lbroennimann/assembly_annotation_course/MAKER
cd ${working_dir}

base="run_mpi"
output_tag=MAKER_flye_annot

cd ${base}.maker.output

gff3_merge -d ${base}_master_datastore_index.log -o ${output_tag}.all.maker.gff
gff3_merge -d ${base}_master_datastore_index.log -n -o ${output_tag}.all.maker.noseq.gff
fasta_merge -d ${base}_master_datastore_index.log -o ${output_tag}

protein=${output_tag}.all.maker.proteins.fasta
transcript=${output_tag}.all.maker.transcripts.fasta
gff=${output_tag}.all.maker.noseq.gff
prefix=${output_tag}_

cp $gff ${gff}.renamed.gff
cp $protein ${protein}.renamed.fasta
cp $transcript ${transcript}.renamed.fasta

maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > ${base}.id.map
map_gff_ids ${base}.id.map ${gff}.renamed.gff
map_fasta_ids ${base}.id.map ${protein}.renamed.fasta
map_fasta_ids ${base}.id.map ${transcript}.renamed.fasta


