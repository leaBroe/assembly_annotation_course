#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=convert
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/conversion/logs/conversion_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/conversion/logs/conversion_%j.e
#SBATCH --partition=pall

input_dir=/data/users/lbroennimann/assembly_annotation_course/2nd_part_annotation/TEsorter
output_dir=/data/users/lbroennimann/assembly_annotation_course/conversion

# Define the color mapping for each clade
declare -A color_mapping
color_mapping["Reina"]="#FF0000"
color_mapping["Retand"]="#00FF00"
color_mapping["CRM"]="#FFA500"
color_mapping["Tekay"]="#0000FF"
color_mapping["Athila"]="#FFFF00"

# Process the input TSV file
awk -F'\t' -v Reina="${color_mapping[Reina]}" \
    -v Retand="${color_mapping[Retand]}" \
    -v CRM="${color_mapping[CRM]}" \
    -v Tekay="${color_mapping[Tekay]}" \
    -v Athila="${color_mapping[Athila]}" \
'
BEGIN {
    OFS = " ";  # Set the output field separator to space
    color_mapping["Reina"] = Reina;
    color_mapping["Retand"] = Retand;
    color_mapping["CRM"] = CRM;
    color_mapping["Tekay"] = Tekay;
    color_mapping["Athila"] = Athila;
    print "#TE_family", "hex_color_code", "Clade";  # Print header
}
NR > 1 {
    print $1, color_mapping[$4], $4;
}' ${input_dir}/Gypsy.cls.tsv > ${output_dir}/output_Gypsy_converted.tsv


