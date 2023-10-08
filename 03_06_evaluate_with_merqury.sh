#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --job-name=merqury_evaluation
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/evaluation/merqury_logs/output_merqury_evaluation_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/evaluation/merqury_logs/error_merqury_evaluation_%j.e
#SBATCH --partition=pall

### Run this script 4 times.
#1. assembly_name=canu; evaulation_dir=${polish_evaluation_dir}/evaluation;           meryl_dir=${evaulation_dir}/meryl;                   assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta 
#2. assembly_name=flye; evaulation_dir=${polish_evaluation_dir}/evaluation;           meryl_dir=${evaulation_dir}/meryl;                   assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta
#3. assembly_name=canu; evaulation_dir=${polish_evaluation_dir}/evaluation_no_polish; meryl_dir=${polish_evaluation_dir}/evaluation/meryl; assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta
#4. assembly_name=flye; evaulation_dir=${polish_evaluation_dir}/evaluation_no_polish; meryl_dir=${polish_evaluation_dir}/evaluation/meryl; assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly_name=canu
    assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        raw_data_dir=${course_dir}/participant_3
        polish_evaluation_dir=${course_dir}/assembly_validation/bowtie2/03_polish_evaluation
            #evaulation_dir=${polish_evaluation_dir}/evaluation
            evaulation_dir=${polish_evaluation_dir}/evaluation_no_polish #Use this instead of the upper one when analysing the not polished assemblies
                #meryl_dir=${evaulation_dir}/meryl
                meryl_dir=${polish_evaluation_dir}/evaluation/meryl #Use this instead of the upper one when analysing the not polished assemblies
                merqury_dir=${evaulation_dir}/merqury
                    assembly_merqury_dir=${merqury_dir}/${assembly_name}
    
    mkdir ${merqury_dir}
    mkdir ${assembly_merqury_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta #Polished canu assembly
    #assembly=${course_dir}/assembly/canu/pacbio_assemblies/ERR3415819_ERR3415820_canu/ERR3415819.contigs.fasta #Unpolished canu assembly
    #assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta #Polished flye assembly
    assembly=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta #Unpolished flye assembly

#Change permisson of assembly otherwise there is an error (I did not fully understand why) and go to folder where results should be stored.
    chmod ugo+rwx ${assembly}
    cd ${assembly_merqury_dir}

#Run merqury to assess quality of the assemblies; do not indent
apptainer exec \
--bind $course_dir \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${meryl_dir}/genome.meryl ${assembly} ${assembly_name}