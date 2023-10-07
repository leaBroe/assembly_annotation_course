#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=pilon_polishing
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/assembly_validation/pilon/logs/output_pilon_polishing_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/assembly_validation/pilon/logs/error_pilon_polishing_%j.e
#SBATCH --partition=pall

### Run this script 2 times.
#1. assembly_name=canu; assembly=${course_dir}/assembly/canu/pacbio_assemblies/ERR3415819_ERR3415820_canu/ERR3415819.contigs.fasta
#2. assembly_name=flye; assembly=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly_name=canu
    assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        polish_evaluation_dir=${course_dir}/assembly_validation/bowtie2/03_polish_evaluation
            polish_dir=${polish_evaluation_dir}/polish
                pilon_dir=${polish_dir}/pilon
                    assembly_pilon_dir=${pilon_dir}/${assembly_name}
    

    mkdir ${pilon_dir}        
    mkdir ${assembly_pilon_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly=${course_dir}/assembly/canu/pacbio_assemblies/ERR3415819_ERR3415820_canu/ERR3415819.contigs.fasta
    assembly=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta

#Run pilon to polish the assemblies
    java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
    --genome ${assembly} --frags ${polish_dir}/align/${assembly_name}/${assembly_name}.bam --output ${assembly_name} --outdir ${assembly_pilon_dir}
        #Options entered here are:
            #"--gemone": The input genome we are trying to improve, which must be the reference used for the bam alignments.
            #"--frags": A bam file consisting of fragment paired-end alignments, aligned to the --genome argument using bwa or bowtie2.
            #"--output": Prefix for output files
            #"--outdir": Use this directory for all output files.

