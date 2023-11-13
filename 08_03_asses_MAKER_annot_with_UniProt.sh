#!/usr/bin/env bash

#SBATCH --cpus-per-task=30
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --job-name=UniProt_evaluation
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/output_UniProt_evaluation_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/error_UniProt_evaluation_%j.e
#SBATCH --partition=pall

#Add the modules
    module add Blast/ncbi-blast/2.10.1+
    module add SequenceAnalysis/GenePrediction/maker/2.31.9

#Define other dictionaries and variables that are used
    input_dir=/data/users/lbroennimann/assembly_annotation_course/MAKER/run_mpi.maker.output

#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        quality_dir=${course_dir}/MAKER
            UniProt_dir=${quality_dir}/UniProt_assessment
                blastdb_dir=${UniProt_dir}/blastdb
   
    mkdir ${UniProt_dir}
    mkdir ${UniProt_dir}

#Specify the assembly to use
    assembly=${input_dir}/MAKER_flye_annot.all.maker.proteins.fasta.renamed.fasta

#Go to folder where the evaluation results will be stored
    cd ${UniProt_dir}

#Align protein against UniProt database
    makeblastdb -in ${course_dir}/MAKER/CDS_annotation/uniprot-plant_reviewed.fasta -dbtype prot -out ${blastdb_dir}/uniprot-plant_reviewed
    blastp -query ${assembly} -db ${blastdb_dir}/uniprot-plant_reviewed -num_threads 30 -outfmt 6 -evalue 1e-10 -out ${UniProt_dir}/blastp.out

#Map protein putative functions
    # cp ${assembly} ${assembly}.Uniprot
    # cp ${input_dir}/polished.all.maker.noseq.gff.renamed.gff ${input_dir}/polished.all.maker.noseq.gff.renamed.gff.Uniprot

    # maker_functional_fasta ${course_dir}/CDS_annotation/uniprot-plant_reviewed.fasta ${UniProt_dir}/blastp.out ${assembly}.Uniprot
    # maker_functional_gff ${course_dir}/CDS_annotation/uniprot-plant_reviewed.fasta ${UniProt_dir}/blastp.out ${input_dir}/polished.all.maker.noseq.gff.renamed.gff.Uniprot