#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=trinity_BUSCO_evaluation
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/evaluation/busco_logs/output_BUSCO_evaluation_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/evaluation/busco_logs/error_BUSCO_evaluation_%j.e
#SBATCH --partition=pall

### Run this script 5 times.
#1. assembly_name=canu;    evaulation_dir=${polish_evaluation_dir}/evaluation;           assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta 
#2. assembly_name=flye;    evaulation_dir=${polish_evaluation_dir}/evaluation;           assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta
#3. assembly_name=trinity; evaulation_dir=${polish_evaluation_dir}/evaluation;           assembly=${course_dir}/02_assembly/trinity/Trinity.fasta
#4. assembly_name=canu;    evaulation_dir=${polish_evaluation_dir}/evaluation_no_polish; assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta
#5. assembly_name=flye;    evaulation_dir=${polish_evaluation_dir}/evaluation_no_polish; assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Add the modules
    module add UHTS/Analysis/busco/4.1.4

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly_name=canu
    #assembly_name=flye
    assembly_name=trinity


#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        polish_evaluation_dir=${course_dir}/assembly_validation/bowtie2/03_polish_evaluation
            #evaulation_dir=${polish_evaluation_dir}/evaluation
             evaulation_dir=${polish_evaluation_dir}/evaluation_no_polish #Use this instead of the upper one when analysing the not polished assemblies
                BUSCO_dir=${evaulation_dir}/BUSCO
                    assembly_BUSCO_dir=${BUSCO_dir}/${assembly_name}
    
    mkdir ${evaulation_dir}
    mkdir ${BUSCO_dir}
    mkdir ${assembly_BUSCO_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    #assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta #Polished canu assembly
    #assembly=${course_dir}/assembly/canu/pacbio_assemblies/ERR3415819_ERR3415820_canu/ERR3415819.contigs.fasta #Unpolished canu assembly
    # assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta #Polished flye assembly
    #assembly=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta #Unpolished flye assembly
    assembly=${course_dir}/assembly/RNAseq_assemblies/SRR1584462_2_trinity_assembly/Trinity.fasta #Unpolished trinity assembly -> but is in evaulation folder

#Go to folder where the evaluation results will be stored
    cd ${assembly_BUSCO_dir}

#Make a copy of the augustus config directory to a location where I have write permission
    cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
    export AUGUSTUS_CONFIG_PATH=./augustus_config

#Run busco to assess the quality of the assemblies
    busco -i ${assembly} -l brassicales_odb10 -o ${assembly_name} -m genome --cpu 8 -f
        #Options entered here are:
            #"-i": Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set.
            #"-l": Specify the name of the BUSCO lineage to be used.
            #"-o": defines the folder that will contain all results, logs, and intermediate data
            #"-m": Specify which BUSCO analysis mode to run, genome, proteins, transcriptome (!!!FOR THE CANU AND FLYE ASSEMBLY I USE GENOME AND FOR THE TRINITRY ASSEMBLY I USE TRANSCRIPTOME!!!)
            #"--cpu": Specify the number (N=integer) of threads/cores to use.

#Remove the augustus config directory again
    rm -r ./augustus_config