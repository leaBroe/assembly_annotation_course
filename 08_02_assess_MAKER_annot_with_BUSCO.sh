#!/usr/bin/env bash

#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --partition=pall

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=20:00:00

#SBATCH --job-name=eval_maker_with_busco
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/BUSCO_eval_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/BUSCO_eval_%j.e

#Add the modules
    module add UHTS/Analysis/busco/4.1.4

#Define other dictionaries and variables that are used
    input_dir=/data/users/lbroennimann/assembly_annotation_course/MAKER/run_mpi.maker.output

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        quality_dir=${course_dir}/MAKER
            BUSCO_dir=${quality_dir}/BUSCO_assessment_output
   
    mkdir ${quality_dir}
    mkdir ${BUSCO_dir}

#Specify the assembly to use
    assembly=${input_dir}/MAKER_flye_annot.all.maker.proteins.fasta.renamed.fasta

#Go to folder where the evaluation results will be stored
    cd ${BUSCO_dir}

#Make a copy of the augustus config directory to a location where I have write permission
    cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
    export AUGUSTUS_CONFIG_PATH=./augustus_config

#Run busco to assess the quality of the assemblies
    busco -i ${assembly} -l brassicales_odb10 -o BUSCO -m proteins -c 8
        #Options entered here are:
            #"-i": Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set.
            #"-l": Specify the name of the BUSCO lineage to be used.
            #"-o": defines the folder that will contain all results, logs, and intermediate data
            #"-m": Specify which BUSCO analysis mode to run, genome, proteins, transcriptome 
            #"-c": Specify the number (N=integer) of threads/cores to use.

#Remove the augustus config directory again
    rm -r ./augustus_config