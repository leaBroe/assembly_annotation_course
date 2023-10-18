#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10G
#SBATCH --time=03:00:00
#SBATCH --job-name=EDTA_annotation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_EDTA_annotation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_EDTA_annotation_%j.e
#SBATCH --partition=pall

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        annotation_dir=${course_dir}/05_annotation_new
    
    mkdir ${annotation_dir}

#Define other dictionaries that are used
    input_dir=/data/users/mfaye/assembly_course/data/assemblies/flye_out/
    COURSEDIR=/data/courses/assembly-annotation-course

#Go to folder where results should be stored.
    cd ${annotation_dir}

#Run EDTA to ; do not indent
singularity exec \
--bind ${COURSEDIR} \
--bind ${annotation_dir} \
--bind ${input_dir} \
${COURSEDIR}/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome ${input_dir}/polished.fasta \
--species others \
--step all \
--cds ${COURSEDIR}/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated \
--anno 1 \
--threads 50
    #"singularity exec":
    #"--bind ${COURSEDIR}":
    #"--bind ${annotation_dir}":
    #"--bind ${input_dir}":
    #"${COURSEDIR}/containers2/EDTA_v1.9.6.sif":
    #"EDTA.pl":
    #"--genome ${input_dir}/polished.fasta":
    #"--species others":
    #"--step all":
    #"--cds ${COURSEDIR}/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated":
    #"--anno 1":
    #"--threads 5":
