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

# Workflow
## Week 1 - reads & QC  
The goal for week 1 involved conducting Quality Control (QC) on the datasets and executing k-mer counting. This step is crucial for assessing the quality of the data and for understanding the complexity of the genome through the distribution and frequency of k-mers. For the k-mer counting an additional script was used best_k.sh in the repository [https://github.com/marbl/merqury.git](https://github.com/marbl/merqury.git), with the genomsize as 135'000'000, which resulted in an optimal k of 19.  

Scripts:[01_01_get_read_statistics.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/01_01_get_read_statistics.sh), [01_02_perform_k_mer_counting.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/01_02_perform_k_mer_counting.sh)    

Software: fastqc 0.11.9, jellyfish 2.3.0  

Input:  
1.1: Raw reads (fastq)  
1.2: Raw reads (fastq) 

Output: read_QC  
1.1: fastqc  
1.2: kmer_counts  

## Week 2 - assembly  
During week 2, the objective was to create three assemblies: two whole-genome assemblies and one whole-transcriptome assembly. For the whole-genome assemblies, the Flye and Canu software were used, utilizing PacBio sequencing reads. Meanwhile, the whole-transcriptome assembly was conducted using the Trinity software, with the process based on RNAseq reads.  

Scripts: [02_01_perform_flye_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_01_perform_flye_assembly.sh), [02_02_perform_canu_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_02_perform_canu_assembly.sh), [02_03_perform_trinity_assembly.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/02_03_perform_trinity_assembly.sh)  

Software: flye 2.8.3, canu 2.1.1, trinityrnaseq 2.11.0  

Input:  
2.1: Raw reads of pacbio (fastq)  
2.2: Raw reads of pacbio (fastq)  
2.3: Raw reads of RNAseq (fastq)  

Output: assembly  
2.1: flye  
2.2: canu  
2.3: trinity  

## Week 3 - assembly polishing and evaluation
The focus for week 3 was on refining and assessing the raw genome assemblies. This refinement, or 'polishing', of the assemblies was performed using Illumina sequencing reads. Scripts 3.1 and 3.2 were executed on the initial, unpolished assemblies produced by both Canu and Flye. For evaluation purposes, all assemblies were considered. Script 3.3 was applied to the unpolished assemblies from Canu, Flye, and Trinity, as well as to the polished assemblies from Canu and Flye. Furthermore, scripts 3.4 and 3.6 were used on both the unpolished and polished assemblies from Canu and Flye.  

Scripts: [03_01_polish_with_bowtie2.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_01_polish_with_bowtie2.sh), [03_02_polish_with_pilon.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_02_polish_with_pilon.sh), [03_03_evaluate_with_BUSCO.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_03_evaluate_with_BUSCO.sh), [03_04_evaluate_with_QUAST.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_04_evaluate_with_QUAST.sh), [03_05_evaluate_with_meryl.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_05_evaluate_with_meryl.sh), [03_06_evaluate_with_merqury.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/03_06_evaluate_with_merqury.sh)  

Software: bowtie2 2.3.4.1, samtools 1.10, pilon 1.22, busco 4.1.4, quast 4.6.0, merqury 1.3.1  

Input:  
3.1: Raw assembly of canu and flye (fasta)  
3.2: Raw assembly of canu and flye (fasta)  
3.3: Raw and polished assembly of canu and flye, raw assembly of trinity (fasta)  
3.4: Raw and polished assembly of canu and flye, reference of Arabidopsis thaliana genome (fasta)  
3.5: Raw reads of illumina (fasta)  
3.6: Raw and polished assembly of canu and flye (fasta), meryl file of genome (meryl)  

Output: assembly_validation  
3.1: polish/index; polish/align  
3.2: polish/pilon  
3.3: evaluation/BUSCO; evaluation_no_polish/BUSCO  
3.4: evaluation/QUAST; evaluation_no_polish/QUAST  
3.5: evaluation/meryl  
3.6: evaluation/merqury; evaluation_no_polish/merqury  

## Week 4 - comparing genomes
The goal of week 4 was to compare the assemblies from Canu and Flye to the Arabidopsis thaliana reference and to each other.  

Scripts: [04_01_compare_with_nucmer.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/04_01_compare_with_nucmer.sh), [04_02_compare_with_mummer.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/04_02_compare_with_mummer.sh)  

Software: mummer 4.0.0 beta 1

Input:  
4.1: Raw assembly of canu and flye, reference of Arabidopsis thaliana genome (fasta)  
4.2: Raw assembly of canu and flye, reference of Arabidopsis thaliana genome (fasta), nucmer delta file (delta)  
Output: comparison  
4.1: nucmer  
4.2: mummer  

## Week 5 - Annotation of Transposable Elements
In week 5, the primary aim was to create a filtered, non-redundant library of Transposable Elements (TEs) suitable for annotating both structurally intact and fragmented elements. Following this, the TEs were categorized based on their mode of transposition. Class I TEs transpose through an RNA intermediate, a process often described as "copy and paste," while Class II TEs move as a DNA molecule, akin to "cut and paste." Further classification involved organizing these TEs into more specific groups, including subclasses, orders, superfamilies, clades, and families.   

The group decided to take the polished flye and trinity assembly of Mansour (Github repository: [https://github.com/MansFaye](https://github.com/MansFaye)).  

Scripts: [05_01_EDTA_annotation.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_01_EDTA_annotation.sh), [05_02.1_extract_sequences.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_02.1_extract_sequences.sh), [05_02.2_classify_with_TESorter.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/05_02.2_classify_with_TESorter.sh), [05_03_visualize_TE_superfamilies.R (https://github.com/leaBroe/assembly_annotation_course/blob/master/05_03_visualize_TE_superfamilies.R)  

Software: EDTA 1.9.6, TEsorter 1.3.0, SeqKit 0.13.2, R 4.3.0  

Input:
5.1: polished assembly flye, (TAIR10_cds_20110103_representative_gene_model_updated)  
5.2: polished.fasta.mod.EDTA.TElib.fa (output of EDTA), Brassicaceae_repbase_all_march2019.fasta  
5.3: polished.fasta.mod.EDTA.TEanno.gff3 (output of EDTA)  

Output: 2nd_part_annotation  
5.1: EDTA  
5.2: TEsorter  

Container  
5.1:  
singularity  
/data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif  
5.2:  
singularity  
/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif  

## Week 6 - Dynamics of Transposable elements
The sixth week's objective was to determine the insertion age of Transposable Elements (TEs), achievable by measuring their divergence from a consensus sequence. This approach is based on the premise that all copies within the same family originate from a single active element, initially identical at the time of insertion, and subsequently accumulate mutations over time. Additionally, week 6 involved studying the phylogenetic relationships among TEs, identifying groups of TEs that share a common ancestral sequence. Most such studies analyse well characterised protein coding sequences, such as the reverse transcriptase, ribonuclease H and integrase for LTR retrotransposons, and transposase for DNA transposons. The analysis specifically targeted the copia and gypsy superfamilies of retrotransposons.    

Scripts: [06_01_date_TEs.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_01_date_TEs.sh), [06_02_plot_div.R](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_02_plot_div.R), [06_03_analyse_phylogenetics_of_TEs.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_03_analyse_phylogenetics_of_TEs.sh), [06_04_convert_tsv_files_for_trees.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/06_04_convert_tsv_files_for_trees.sh)  
Software: R 4.3.0, SeqKit 0.13.2, clustal-omega 1.2.4, FastTree 2.1.10  

Input:  
6.1: polished.fasta.mod.out (output of EDTA)  
6.2: polished.fasta.sed.tab (output of 6.1)  
6.3: *dom.faa (output of 5.2) of both families  

Output: phylogenetic_analysis_TEs and TE_dating  
6.2: TE-myr_lines.pdf, TE-myr.pdf  
6.3: TE_phylogeny  

Container  
6.1:  
Create an environment:  
conda create -n assembly_course_environment  
conda install -c bioconda perl-bioperl  

## Week 7 - Annotation of protein-coding sequences
In week 7, the aim was to carry out genome annotation and establish a genome database. For this purpose, the MAKER pipeline was employed. This tool integrates various types of data into gene annotations: 1. models predicted from scratch (ab initio prediction models), 2. evidence of gene expression, and 3. sequence similarity to already known proteins.   

Scripts: [07_01_perform_annotation_with_MAKER.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/07_01_perform_annotation_with_MAKER.sh), [07_01_perform_annotation_with_MAKER_opts.ctl](https://github.com/leaBroe/assembly_annotation_course/blob/master/07_01_perform_annotation_with_MAKER_opts.ctl)  

Software: MAKER 2.31.9

Input:  
7.1: polished flye assembly and trinity assembly  
7.2: polished_master_datastore_index.log (output of maker)  

Output: MAKER    
7.1: polished.maker.output  
7.2: polished.maker.output.renamed    

Container  
7.1:  
singularity  
/data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif  

## Week 8 - Assess annotation quality
During week 8, the objective was to evaluate the quality of the annotations. This was achieved by examining the completeness of the annotation using the Benchmarking Universal Single-Copy Orthologs (BUSCO) software. Additionally, we analysed of the sequence similarity with proteins that have been functionally validated. For this purpose, the UniProt database was utilized as a key resource.  

Scripts: [08_01_create_fasta_and_gff_from_MAKER.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_01_create_fasta_and_gff_from_MAKER.sh), [08_02_assess_MAKER_annot_with_BUSCO.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_02_assess_MAKER_annot_with_BUSCO.sh), [08_03_asses_MAKER_annot_with_UniProt.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_03_asses_MAKER_annot_with_UniProt.sh)  

Software: busco 4.1.4, ncbi-blast 2.10.1+  

Input:  
8.1 & 8.2: polished.all.maker.proteins.fasta.renamed.fasta (output of maker then processed with script [08_01_create_fasta_and_gff_from_MAKER.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/08_01_create_fasta_and_gff_from_MAKER.sh))  

Output: MAKER  
8.1: BUSCO_assessment_output  
8.2: UniProt_assessment  

## Week 9 - Comparative genomics
In week 9, the focus was on analyzing the similarities in the protein sequences of species that are closely related, using comparative genomics techniques. This involved examining a set of genes known as an orthogroup, which originate from a single ancestral gene shared by different species. By charting the proportion of genes within these orthogroups, we can effectively monitor the quality of our data. Typically, we anticipate a substantial proportion of these genes. However, this expectation may not hold if the proteomic data includes a species that is distantly related.   

Scripts: [09_01_comparative_genomics_with_GENESPACE.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/09_01_comparative_genomics_with_GENESPACE.sh), [09_02_run_GENESPACE.sh](https://github.com/leaBroe/assembly_annotation_course/blob/master/09_02_run_GENESPACE.sh), [09_03_parse_orthofinder.R](https://github.com/leaBroe/assembly_annotation_course/blob/master/09_03_parse_orthofinder.R)  

Software: SeqKit 0.13.2, R 4.2.3, GENESPACE 1.1.4  

Input:  
9.1: *.all.maker.noseq.gff.renamed.gff, *.all.maker.proteins.fasta.renamed.fasta  
9.2: bed, peptide, noseq, proteins  
9.3: Statistics_PerSpecies.tsv  

Output: 8_comparative_genomics  
9.1: bed, peptide  
9.2: genespace  
9.3: Orthofinder  

Container  
9.2:  
apptainer  
/data/users/lbroennimann/assembly_annotation_course/scripts/genespace_1.1.4.sif
