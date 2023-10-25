#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=dating_TEs
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/TE_dating/logs/TE_dating_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/TE_dating/logs/TE_dating_%j.e
#SBATCH --partition=pall

# install one of the following in your environment
# conda install -c bioconda perl-bioperl
# consta install -c "bioconda/label/cf201901" perl-bioperl

# activate environment
# conda activate anno_course

course_dir=/data/users/lbroennimann/assembly_annotation_course
input_dir=${course_dir}/polished.fasta.mod.EDTA.anno/polished.fasta.mod.out
output_dir=${course_dir}/TE_dating
script_dir=${course_dir}/scripts

cd ${output_dir}
perl ${script_dir}/parseRM.pl -i ${input_dir} -l 50,1 -v

# Modify the output file $genome.mod.out.landscape.Div.Rname.tab by removing the first and the 3rd line:
output_dir_2=${course_dir}/polished.fasta.mod.EDTA.anno

cd ${output_dir}
sed '1d;3d' ${output_dir_2}/polished.fasta.mod.out.landscape.Div.Rname.tab > ${output_dir}/modified.fasta.mod.out.landscape.Div.Rname.tab

