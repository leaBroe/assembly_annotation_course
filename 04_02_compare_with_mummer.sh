#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=mummer_comparison
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/comparison/logs/output_mummer_comparison_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/comparison/logs/error_mummer_comparison_%j.e
#SBATCH --partition=pall

### Run this script 2 times.
#1. assembly_name=canu; assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
#2. assembly_name=flye; assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta

#Add the modules
    module add UHTS/Analysis/mummer/4.0.0beta1

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
    raw_data_dir=${course_dir}/participant_3
    polish_evaluation_dir=${course_dir}/assembly_validation/bowtie2/03_polish_evaluation
        comparison_dir=${course_dir}/comparison
            nucmer_dir=${comparison_dir}/nucmer
                assembly_nucmer_dir=${nucmer_dir}/${assembly_name}
            mummer_dir=${comparison_dir}/mummer
                assembly_mummer_dir=${mummer_dir}/${assembly_name}
    
    mkdir ${mummer_dir}
    mkdir ${assembly_mummer_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
    # assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta

#Specify the reference genome
    reference=${course_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa


#Specify the delta file to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    match_file=${assembly_nucmer_dir}/canu.delta #Not sure if this is right yet. Have to run nucmer first and see what the output is.
    # match_file=${assembly_nucmer_dir}/flye.delta #Not sure if this is right yet. Have to run nucmer first and see what the output is.

#Run mummerplot to show results
    mummerplot -f -l -R ${reference} -Q ${assembly} --large --png ${match_file}
        #Options entered here are:
            #"-f": Only display alignments which represent the "best" one-to-one mapping of reference and query subsequences (requires delta formatted input)
            #"-l": Layout a multiplot by ordering and orienting sequences such that the largest hits cluster near the main diagonal (requires delta formatted input)
            #"-R": Generate a multiplot by using the order and length information contained in this file, either a FastA file of the desired reference sequences or a tab-delimited list of sequence IDs, lengths and orientations [ +-]
            #"-Q": Generate a multiplot by using the order and length information contained in this file, either a FastA file of the desired query sequences or a tab-delimited list of sequence IDs, lengths and orientations [ +-]
            #"--large": Set the output size to small, medium or large --small --medium --large
            #"--png": Set the output terminal to x11, postscript or png