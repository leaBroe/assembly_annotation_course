# Genome and Transcriptome Assembly Course HS23

This is a project of the course *Genome and Transcriptome Assembly* (473637-HS2023) of the University of Bern. It takes place in the Fall Semester 2023. The course webpage can be found [here](https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/).

The primary goal is to conduct a comprehensive assembly and annotation using whole genome NGS data from Arabidopsis thaliana.

**Objectives:**
1) Understand the theoretical principles behind algorithmic assembly.
2) Implement these principles on data from both model and non-model organisms.
3) Evaluate the quality throughout the entire process, from data production to the genome/transcriptome assembly.
4) Annotate the genome by aligning the transcriptome assembly data with the genome assembly data.


Path to my project folder on the IBU cluster: **/data/users/lbroennimann/assembly_annotation_course**

## Datasets

The datasets that are used come from:

Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics. Nature Communications. 2020;11:1–10. Available from: [http://dx.doi.org/10.1038/s41467-020-14779-y](http://dx.doi.org/10.1038/s41467-020-14779-y)

### My datasets

* Accession: C24
* Data set: 3
* Illumina: ERR3624577_1.fastq.gz, ERR3624577_2.fastq.gz
* pacbio: ERR3415819.fastq.gz, ERR3415820.fastq.gz
* RNAseq: SRR1584462_1.fastq.gz, SRR1584462_2.fastq.gz

Path to data sets on the IBU cluster: **/data/courses/assembly-annotation-course/raw_data/[ACCESSION]/[DATASET]**

# Overview of the Scripts:

## Quality Control
- [01_01_get_read_statistics.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/01_01_get_read_statistics.sh): Retrieves statistics related to the reads.
- [01_02_perform_k_mer_counting.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/01_02_perform_k_mer_counting.sh): Performs k-mer counting.

## Assembly
- [02_01_perform_flye_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_01_perform_flye_assembly.sh): Assembles sequences using the Flye tool.
- [02_02_perform_canu_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_02_perform_canu_assembly.sh): Assembles sequences using the Canu tool.
- [02_03_perform_trinity_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_03_perform_trinity_assembly.sh): Assembles sequences using the Trinity tool.

## Evaluation and Validation
- [03_01_polish_with_bowtie2.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_01_polish_with_bowtie2.sh): Polishes the assembled sequences using Bowtie2.
- [03_02_polish_with_pilon.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_02_polish_with_pilon.sh): Polishes the assembled sequences using Pilon.
- [03_03_evaluate_with_BUSCO.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_03_evaluate_with_BUSCO.sh): Evaluates the assembly using BUSCO.
- [03_04_evaluate_with_QUAST.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_04_evaluate_with_QUAST.sh): Evaluates the assembly using QUAST.
- [03_05_evaluate_with_meryl.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_05_evaluate_with_meryl.sh): Evaluates the assembly using Meryl.
- [03_06_evaluate_with_merqury.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_06_evaluate_with_merqury.sh): Evaluates the assembly using Merqury.

## Comparison of Assemblies
- [04_01_compare_with_nucmer.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/04_01_compare_with_nucmer.sh): Compares assemblies using Nucmer.
- [04_02_compare_with_mummer.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/04_02_compare_with_mummer.sh): Compares assemblies using Mummer.

