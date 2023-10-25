#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=phylo_TEs
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs/logs/phylo_analysis_TEs_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs/logs/phylo_analysis_TEs_%j.e
#SBATCH --partition=pall

# Extract RT protein sequences from the $.rexdb-plant.dom.faa file of your Arabidopsis
# accession using seqkit grep.
# Gypsy RT proteins are named as Ty3-RT, Copia RT proteins as Ty1-RT.

course_dir=/data/users/lbroennimann/assembly_annotation_course
fasta_dir=${course_dir}/2nd_part_annotation/TEsorter

module add UHTS/Analysis/SeqKit/0.13.2

grep Ty1-RT ${fasta_dir}/Copia.dom.faa > Copia_list.txt # make a list of RT proteins to extract
#grep Ty3-RT ${fasta_dir}/Gypsy.dom.faa > Gypsy_list.txt # make a list of RT proteins to extract


sed -i 's/>//' Copia_list.txt #remove ">" from the header
#sed -i 's/>//' Gypsy_list.txt #remove ">" from the header


sed -i 's/ .\+//' Copia_list.txt #remove all characters following "empty space" from the header
#sed -i 's/ .\+//' Gypsy_list.txt #remove all characters following "empty space" from the header

seqkit grep -f Copia_list.txt ${fasta_dir}/Copia.dom.faa -o Copia_RT.fasta
#seqkit grep -f Gypsy_list.txt ${fasta_dir}/Gypsy.dom.faa -o Gypsy_RT.fasta

mv Copia_list.txt Copia_RT.fasta /data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs/
#mv Gypsy_list.txt Gypsy_RT.fasta /data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs/

output_dir=/data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs

sed 's/|.\+//' ${output_dir}/Copia_RT.fasta > ${output_dir}/rm_Copia_RT.fasta #remove all characters following "|"
#sed 's/|.\+//' ${output_dir}/Gypsy_RT.fasta > ${output_dir}/rm_Gypsy_RT.fasta #remove all characters following "|"

# Align sequences using clustal omega
module load SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4

clustalo -i ${output_dir}/rm_Copia_RT.fasta -o ${output_dir}/protein_alignment_Copia.fasta
#clustalo -i ${output_dir}/rm_Gypsy_RT.fasta -o ${output_dir}/protein_alignment_Gypsy.fasta

# Create a phylogenetic tree with FastTree (approximately-maximum-likelihood).

module load Phylogeny/FastTree/2.1.10

FastTree -out ${output_dir}/Copia_protein_alignment.tree ${output_dir}/protein_alignment_Copia.fasta
#FastTree -out ${output_dir}/Gypsy_protein_alignment.tree ${output_dir}/protein_alignment_Gypsy.fasta

