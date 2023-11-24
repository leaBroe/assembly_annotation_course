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

## Quality Control of the Reads
- [01_01_get_read_statistics.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/01_01_get_read_statistics.sh): Retrieves statistics related to the reads.
- [01_02_perform_k_mer_counting.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/01_02_perform_k_mer_counting.sh): Performs k-mer counting.

## Assembly
- [02_01_perform_flye_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_01_perform_flye_assembly.sh): Assembles sequences using the Flye tool.
- [02_02_perform_canu_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_02_perform_canu_assembly.sh): Assembles sequences using the Canu tool.
- [02_03_perform_trinity_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_03_perform_trinity_assembly.sh): Assembles sequences using the Trinity tool.

## Evaluation and Validation of Assembly
- [03_01_polish_with_bowtie2.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_01_polish_with_bowtie2.sh): Polishes the assembled sequences using Bowtie2.
- [03_02_polish_with_pilon.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_02_polish_with_pilon.sh): Polishes the assembled sequences using Pilon.
- [03_03_evaluate_with_BUSCO.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_03_evaluate_with_BUSCO.sh): Evaluates the assembly using BUSCO.
- [03_04_evaluate_with_QUAST.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_04_evaluate_with_QUAST.sh): Evaluates the assembly using QUAST.
- [03_05_evaluate_with_meryl.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_05_evaluate_with_meryl.sh): Evaluates the assembly using Meryl.
- [03_06_evaluate_with_merqury.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_06_evaluate_with_merqury.sh): Evaluates the assembly using Merqury.

## Comparison of Assemblies
- [04_01_compare_with_nucmer.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/04_01_compare_with_nucmer.sh): Compares assemblies using Nucmer.
- [04_02_compare_with_mummer.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/04_02_compare_with_mummer.sh): Compares assemblies using Mummer.

## Transposable Elements Annotation
- [05_01_EDTA_annotation.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_01_EDTA_annotation.sh): Annotates transposable elements using EDTA.
- [05_02.1_extract_sequences.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_02.1_extract_sequences.sh): Extracts sequences for further analysis.
- [05_02.2_classify_with_TESorter.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_02.2_classify_with_TESorter.sh): Classifies transposable elements using TESorter.
- [05_03_visualize_TE_superfamilies.R](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_03_visualize_TE_superfamilies.R): Visualizes transposable element superfamilies.

## Transposable Elements Analysis
- [06_01_date_TEs.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_01_date_TEs.sh): Dates transposable elements.
- [06_02_plot_div.R](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_02_plot_div.R): Plots diversity or divergence.
- [06_03_analyse_phylogenetics_of_TEs.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_03_analyse_phylogenetics_of_TEs.sh): Analyses the phylogenetics of transposable elements.
- [06_04_convert_tsv_files_for_trees.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_04_convert_tsv_files_for_trees.sh): Converts TSV files for phylogenetic tree analysis.

## Whole Genome Annotation with MAKER
- [06_05_perform_annotation_with_MAKER.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_05_perform_annotation_with_MAKER.sh): Performs genome annotation using MAKER.
- [07_01_perform_annotation_with_MAKER.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/07_01_perform_annotation_with_MAKER.sh): Another script for genome annotation with MAKER.
- [07_01_perform_annotation_with_MAKER_opts.ctl](https://github.com/leaBroe/assembly_annotation_course/blob/master/07_01_perform_annotation_with_MAKER_opts.ctl): Control file for MAKER annotation.

## MAKER Annotation Evaluation
- [08_01_create_fasta_and_gff_from_MAKER.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_01_create_fasta_and_gff_from_MAKER.sh): Creates FASTA and GFF files from MAKER outputs.
- [08_02_assess_MAKER_annot_with_BUSCO.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_02_assess_MAKER_annot_with_BUSCO.sh): Assesses MAKER annotations with BUSCO.
- [08_03_asses_MAKER_annot_with_UniProt.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_03_asses_MAKER_annot_with_UniProt.sh): Assesses MAKER annotations with UniProt.

## Comparative Genomics
- [09_01_comparative_genomics_with_GENESPACE.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/09_01_comparative_genomics_with_GENESPACE.sh): Performs comparative genomics analysis with GENESPACE.
- [09_02_run_GENESPACE.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/09_02_run_GENESPACE.sh): Runs the GENESPACE tool.
- [09_03_parse_orthofinder.R](https://github.com/leaBroe/assembly_annotation_course/blob/master/09_03_parse_orthofinder.R): Parses OrthoFinder results.


