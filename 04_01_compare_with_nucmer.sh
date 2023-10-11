#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --job-name=nucmer_comparison
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/comparison/logs/output_nucmer_comparison_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/comparison/logs/error_nucmer_comparison_%j.e
#SBATCH --partition=pall

### Run this script 3 times.
#1. assembly_name=canu; assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
#2. assembly_name=flye; assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta
#3. assembly_name=compare; assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta; reference=${course_dir}/02_assembly/flye/assembly.fasta

#Add the modules
    module add UHTS/Analysis/mummer/4.0.0beta1

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly_name=canu
    #assembly_name=flye
    assembly_name=compare

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        raw_data_dir=${course_dir}/participant_3
        polish_evaluation_dir=${course_dir}/assembly_validation/bowtie2/03_polish_evaluation
        comparison_dir=${course_dir}/comparison
            nucmer_dir=${comparison_dir}/nucmer
                assembly_nucmer_dir=${nucmer_dir}/${assembly_name}
    
    mkdir ${comparison_dir}
    mkdir ${nucmer_dir}
    mkdir ${assembly_nucmer_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
    #assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta

#Specify the reference genome
    #reference=${course_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
    reference=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta

#Go to folder where results should be stored.
    cd ${assembly_nucmer_dir}

#Run nucmer to compare assemblies
    nucmer -b 1000 -c 1000 -p ${assembly_name} ${reference} ${assembly}
        #Options entered here are:
            #"-b 1000": Distance an alignment extension will attempt to extend poor scoring regions before giving up (default 200)
            #"-c 1000": Minimum cluster length
            #"-p": Set the output file prefix
