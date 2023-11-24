#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=BUSCO_evaluation
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/evaluation/busco_logs/output_BUSCO_evaluation_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/evaluation/busco_logs/error_BUSCO_evaluation_%j.e
#SBATCH --partition=pall

#Add the modules
module add UHTS/Analysis/busco/4.1.4


assembly_name=assembly_from_paper


assembly_BUSCO_dir=/data/users/lbroennimann/assembly_annotation_course/data_from_paper/BUSCO/${assembly_name}

mkdir ${assembly_BUSCO_dir}


assembly=/data/users/lbroennimann/assembly_annotation_course/data_from_paper/C24.chr.all.v2.0.fasta #C24 assembly from the paper

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

