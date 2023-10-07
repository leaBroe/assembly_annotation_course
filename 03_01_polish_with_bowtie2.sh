#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=bowtie2_polishing
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/assembly_validation/bowtie2/logs/output_bowtie2_polishing_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/assembly_validation/bowtie2/logs/error_bowtie2_polishing_%j.e
#SBATCH --partition=pall

### Run this script 2 times.
#1. assembly_name=canu; assembly=${course_dir}/assembly/canu/pacbio_assemblies/ERR3415819_ERR3415820_canu/ERR3415819.contigs.fasta
#2. assembly_name=flye; assembly=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta


#Add the modules
    module add UHTS/Aligner/bowtie2/2.3.4.1
    module add UHTS/Analysis/samtools/1.10

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    #assembly_name=flye


#Specify directory structure and create them
    course_dir=/data/users/lbroennimann/assembly_annotation_course
        raw_data_dir=${course_dir}/participant_3
        polish_evaluation_dir=${course_dir}/assembly_validation/bowtie2/03_polish_evaluation
            polish_dir=${polish_evaluation_dir}/polish
                index_dir=${polish_dir}/index
                    assembly_index_dir=${index_dir}/${assembly_name}
                align_dir=${polish_dir}/align
                    assembly_align_dir=${align_dir}/${assembly_name}

    mkdir ${polish_evaluation_dir}
    mkdir ${polish_dir}
    mkdir ${index_dir}
    mkdir ${assembly_index_dir}
    mkdir ${align_dir}
    mkdir ${assembly_align_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${course_dir}/assembly/canu/pacbio_assemblies/ERR3415819_ERR3415820_canu/ERR3415819.contigs.fasta
    #assembly=${course_dir}/assembly/flye/pacbio_assemblies/ERR3415819_ERR3415820_assembly/assembly.fasta

#Go to folder where the index should be build
    cd ${assembly_index_dir}

#Run bowtie2 to align the reads to the assembly
    #Create index
        bowtie2-build ${assembly} index_bowtie2
            #Options entered here are:
                #"build": builds a Bowtie index from a set of DNA sequences. 
                #"${assembly}": A comma-separated list of FASTA files containing the reference sequences to be aligned to.
                #"index_bowtie2": The basename of the index files to write.

    #Execute bowtie2
        bowtie2 -p 8 --sensitive-local -x ${assembly_index_dir}/index_bowtie2 -1 ${raw_data_dir}/Illumina/*_1.fastq.gz -2 ${raw_data_dir}/Illumina/*_2.fastq.gz -S $SCRATCH/${assembly_name}.sam
            #Options entered here are:
                #"-p": Launch NTHREADS parallel search threads.
                #"--sensitive-local": gives specific options, so you don't have to enter them all
                #"-x": The basename of the index for the reference genome.
                #"-1/-2": Comma-separated list of files containing mate 1s/2s.
                #"-S": File to write SAM alignments to.

#Convert SAM to BAM
    samtools view -b $SCRATCH/${assembly_name}.sam > $SCRATCH/${assembly_name}_unsorted.bam
        #Options entered here are:
            #"view": Views and converts SAM/BAM/CRAM files.
            #"-b": Output in the BAM format.
            #"*.sam": Input file.
            #"*_unsorted.bam": Output file.

    #Sort BAM
        samtools sort -o $SCRATCH/${assembly_name}.bam $SCRATCH/${assembly_name}_unsorted.bam
            #Options entered here are:
                #"sort": Sort alignments by leftmost coordinates, or by read name when -n is used. 
                #"-o": Write the final sorted output to file, rather than to standard output.

    #Index BAM
        samtools index $SCRATCH/${assembly_name}.bam
            #Options entered here are:
                #"index": Index coordinate-sorted BGZIP-compressed SAM, BAM or CRAM files for fast random access.
    
    #Move the bams created in the temporary folder $SCRATCH to the output folder
        mv $SCRATCH/${assembly_name}.bam* ${assembly_align_dir}