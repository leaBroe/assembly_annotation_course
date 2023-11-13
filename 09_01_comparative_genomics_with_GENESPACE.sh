#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=20:00:00
#SBATCH --job-name=GENESPACE_input
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/output_GENESPACE_input_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/error_GENESPACE_input_%j.e
#SBATCH --partition=pall

### Run this script X times.

module add UHTS/Analysis/SeqKit/0.13.2

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        input_dir=${course_dir}/MAKER/run_mpi.maker.output
        GENESPACE_dir=${course_dir}/09_genespace
            bed_dir=${GENESPACE_dir}/bed
            peptide_dir=${GENESPACE_dir}/peptide

    mkdir ${GENESPACE_dir}
    mkdir ${bed_dir}
    mkdir ${peptide_dir}

#Specify the assembly to use
    genome="MAKER_flye_annot"

#Get all contings and sort them by size
    awk '$3=="contig"' ${input_dir}/${genome}.all.maker.noseq.gff.renamed.gff|sort -t $'\t' -r -k5,5n > ${GENESPACE_dir}/size_sorted_contigs.txt

#Get the 10 longest
    tail ${GENESPACE_dir}/size_sorted_contigs.txt|cut -f1 > ${GENESPACE_dir}/contigs.txt

#Create bed file
    awk '$3=="mRNA"' ${input_dir}/${genome}.all.maker.noseq.gff.renamed.gff|cut -f 1,4,5,9|sed 's/ID=//'|sed 's/;.\+//'|grep -w -f ${GENESPACE_dir}/contigs.txt > ${bed_dir}/C24.bed

#Get the gene IDs
    cut -f4 ${bed_dir}/C24.bed > ${GENESPACE_dir}/gene_IDs.txt

#Create fasta file
    cat ${input_dir}/${genome}.all.maker.proteins.fasta.renamed.fasta|seqkit grep -r -f ${GENESPACE_dir}/gene_IDs.txt |seqkit seq -i > ${peptide_dir}/C24.fa