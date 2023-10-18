# Questions
These questions are copied from the [course website](https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/).

## Week 1
### Basic read statistics
* What are the read lengths of the different datasets?
    * *Illumina: 101; pacbio: 50-45262/50-44540; RNAseq: 101*
* What kind of coverage do you expect from the Pacbio and the Illumina WGS reads? (**hint**: lookup the expected genome size of *Arabidopsis thaliana*)
    * *(sequence lenght $\times$ total sequences) / genome size = coverage*
    * *genome size arabidopsis thaliana*
        * *135 Mb*
    * *Pacbio*
        * *ERR3415819: $ 1'790'410'469 / 135'000'000 $ = 13.26* (from seq_stats.md)
        * *ERR3415820: $ 3'758'288'517 / 135'000'000 $ = 27.84* (from seq_stats.md)
    * *Illumina*
        * *ERR3624577_1/ERR3624577_2: $ 3'412'512'755 / 135'000'000 $ = 25.28* (from seq_stats.md)
* Do all datasets have information on base quality?
    * *No the pacbio data set does not have information about the base quality.*

### Perform k-mer counting
* Is the estimated genome size and percentage of heterozygousity expected?
    * *Illumina: 124'986'561; 0.0591%* from [here](http://genomescope.org/analysis.php?code=F7VqKGM3BOJPqlSiQkQL)
    * *Pacbio: 14'389'033; 3.9%* from [here](http://genomescope.org/analysis.php?code=XoFDoQ69GSXg6cpT1mOG)
    * *RNAseq: 24'932'667; 3.86%* from [here](http://genomescope.org/analysis.php?code=xRw0qwzV2YHYQc5fFOsG)
    * *The results of the illumina WGS reads is expected; The results of the RNA seq and Pacbio reads is underestimated a lot.*
* Bonus: Why are we using canonical k-mers? (use Google)
    * *When counting k-mers in sequencing reads, there is really no way to differentiate between k-mers and their reverse complement. What I mean by this is that seeing e.g. ACGGT is equivalent to seeing ACCGT, since the latter is the reverse complement of the former and the sequenced reads don't originate from a prescribed strand of the DNA. The -C command in jellyfish considers both a k-mer and its reverse complement as equivalent, and associates the count for both (the sum of the count of a kmer and its reverse complement) with the k-mer among the two that is lexicographically smaller. So, for example, above only ACCGT would be stored and its count would be equal to the number of occurrences of both ACCGT and ACGGT. If you don't include -C in your jellyfish options, these k-mers will be treated separately. There's nothing "wrong" with this, per-se, but it may not be what you want.* from [biostars](https://www.biostars.org/p/153170/)

## Week 3
### Results
#### BUSCO

|                            Assembly | flye (p) | flye (r) | canu (p) | canu (r) | trinity (r) |
|-------------------------------------|----------|----------|----------|----------|-------------|
|                 Complete BUSCOs (C) |     4543 |     4509 |     4524 |     4361 |        2985 |
| Complete and single-copy BUSCOs (S) |     4492 |     4455 |     4474 |     4288 |         923 |
|  Complete and duplicated BUSCOs (D) |       51 |       54 |       50 |       73 |        2062 |
|               Fragmented BUSCOs (F) |        3 |       17 |       12 |       61 |         347 |
|                  Missing BUSCOs (M) |       50 |       70 |       60 |      174 |        1264 |
|         Total BUSCO groups searched |     4596 |     4596 |     4596 |     4596 |        4596 |

* *flye (p):    C: 98.8% [S:97.7%,  D:1.1%], F:0.1%,  M:1.1%, n:4596*
* *flye (r):    C: 98.1% [S:96.9%,  D:1.2%], F:0.4%,  M:1.5%, n:4596*
* *canu (p):    C: 98.4% [S:97.3%,  D:1.1%], F:0.3%,  M:1.3%, n:4596*
* *canu (r):    C: 94.9% [S:93.3%,  D:1.6%], F:1.3%,  M:3.8%, n:4596*
* *trinity (r): C: 65.0% [S:20.1%, D:44.9%], F:7.6%, M:27.4%, n:4596*
* From the files short_summary.specific.brassicales_odb10.[assembly].txt

#### QUAST

|                   Assembly | flye (p, w/o) | flye (r, w/o) | canu (p, w/o) | canu (r, w/o) |
|----------------------------|---------------|---------------|---------------|---------------|
|        # contigs (>= 0 bp) |           438 |           438 |           586 |           586 |
|     # contigs (>= 1000 bp) |           372 |           372 |           586 |           586 |
|     # contigs (>= 5000 bp) |           193 |           193 |           581 |           581 |
|    # contigs (>= 10000 bp) |           149 |           150 |           558 |           560 |
|    # contigs (>= 25000 bp) |           113 |           113 |           439 |           440 |
|    # contigs (>= 50000 bp) |            89 |            89 |           366 |           366 |
|     Total length (>= 0 bp) |     119817321 |     119793098 |     120174180 |     120096612 |
|  Total length (>= 1000 bp) |     119775459 |     119751243 |     120174180 |     120096612 |
|  Total length (>= 5000 bp) |     119350031 |     119325729 |     120160297 |     120082760 |
| Total length (>= 10000 bp) |     119030400 |     119015850 |     119971292 |     119913033 |
| Total length (>= 25000 bp) |     118391896 |     118366710 |     118004185 |     117948164 |
| Total length (>= 50000 bp) |     117578581 |     117552113 |     115462131 |     115377261 |
|                  # contigs |           244 |           244 |           583 |           583 |
|             Largest contig |      13041131 |      13039824 |       2467091 |       2465067 |
|               Total length |     119545658 |     119521430 |     120168067 |     120090514 |
| Estimated reference length |     125000000 |     125000000 |     125000000 |     125000000 |
|                     GC (%) |         36.09 |         36.11 |         36.13 |         36.15 |
|                        N50 |       8822047 |       8819554 |        460562 |        460206 |
|                       NG50 |       8822047 |       8819554 |        433815 |        433505 |
|                        N75 |       3987995 |       3987766 |        237709 |        237517 |
|                       NG75 |       1705972 |       1705414 |        211025 |        209127 |
|                        L50 |             6 |             6 |            74 |            74 |
|                       LG50 |             6 |             6 |            79 |            79 |
|                        L75 |            11 |            11 |           167 |           167 |
|                       LG75 |            13 |            13 |           183 |           184 |
|          # N's per 100 kbp |          1.10 |          1.34 |          0.00 |          0.00 |


|                    Assembly |  flye (p, w/) |  flye (r, w/) |  canu (p, w/) |  canu (r, w/) |
|-----------------------------|---------------|---------------|---------------|---------------|
|         # contigs (>= 0 bp) |           438 |           438 |           586 |           586 |
|      # contigs (>= 1000 bp) |           372 |           372 |           586 |           586 |
|      # contigs (>= 5000 bp) |           193 |           193 |           581 |           581 |
|     # contigs (>= 10000 bp) |           149 |           150 |           558 |           560 |
|     # contigs (>= 25000 bp) |           113 |           113 |           439 |           440 |
|     # contigs (>= 50000 bp) |            89 |            89 |           366 |           366 |
|      Total length (>= 0 bp) |     119817321 |     119793098 |     120174180 |     120096612 |
|   Total length (>= 1000 bp) |     119775459 |     119751243 |     120174180 |     120096612 |
|   Total length (>= 5000 bp) |     119350031 |     119325729 |     120160297 |     120082760 |
|  Total length (>= 10000 bp) |     119030400 |     119015850 |     119971292 |     119913033 |
|  Total length (>= 25000 bp) |     118391896 |     118366710 |     118004185 |     117948164 |
|  Total length (>= 50000 bp) |     117578581 |     117552113 |     115462131 |     115377261 |
|                   # contigs |           244 |           244 |           583 |           583 |
|              Largest contig |      13041131 |      13039824 |       2467091 |       2465067 |
|                Total length |     119545658 |     119521430 |     120168067 |     120090514 |
|            Reference length |     119667750 |     119667750 |     119667750 |     119667750 |
|                      GC (%) |         36.09 |         36.11 |         36.13 |         36.15 |
|            Reference GC (%) |         36.06 |         36.06 |         36.06 |         36.06 |
|                         N50 |       8822047 |       8819554 |        460562 |        460206 |
|                        NG50 |       8822047 |       8819554 |        472804 |        472513 |
|                         N75 |       3987995 |       3987766 |        237709 |        237517 |
|                        NG75 |       3987995 |       3987766 |        238409 |        237999 |
|                         L50 |             6 |             6 |            74 |            74 |
|                        LG50 |             6 |             6 |            73 |            73 |
|                         L75 |            11 |            11 |           167 |           167 |
|                        LG75 |            11 |            11 |           165 |           166 |
|             # misassemblies |           815 |           816 |           799 |           796 |
|      # misassembled contigs |            91 |            93 |           282 |           279 |
| Misassembled contigs length |     113588575 |     113612529 |      79867417 |      79831032 |
|       # local misassemblies |          4830 |          4814 |          4865 |          4821 |
|    # unaligned mis. contigs |            35 |            36 |            46 |            46 |
|         # unaligned contigs | 21 + 140 part | 23 + 138 part | 14 + 441 part | 14 + 448 part |
|            Unaligned length |      12391043 |      12428520 |      11749129 |      11861165 |
|         Genome fraction (%) |        88.029 |        87.977 |        87.711 |        87.635 |
|           Duplication ratio |         1.017 |         1.017 |         1.033 |         1.032 |
|           # N's per 100 kbp |          1.10 |          1.34 |          0.00 |          0.00 |
|    # mismatches per 100 kbp |        634.82 |        631.67 |        630.66 |        629.76 |
|        # indels per 100 kbp |        146.12 |        175.85 |        148.04 |        229.83 |
|           Largest alignment |       3020858 |       3020120 |       1314910 |       1314246 |
|        Total aligned length |     107149609 |     107087388 |     108406734 |     108218440 |
|                        NA50 |        501288 |        501109 |        229976 |        229330 |
|                       NGA50 |        498783 |        498642 |        230832 |        230692 |
|                        NA75 |        108854 |        108557 |        72321  |        72220  |
|                       NGA75 |        108593 |        108308 |        74558  |        72928  |
|                        LA50 |            51 |            51 |           142 |           142 |
|                       LGA50 |            52 |            52 |           141 |           141 |
|                        LA75 |           187 |           188 |           374 |           375 |
|                       LGA75 |           188 |           189 |           369 |           371 |

* From the files report.txt

#### Merqury

| Assembly |    flye (p) |    flye (r) |    canu (p) |    canu (r) |
|----------|-------------|-------------|-------------|-------------|
|       2. |      229600 |      775080 |      160487 |     1634172 |
|       3. |   119807837 |   119783326 |   120163632 |   120086064 |
|       4. |     39.9587 |     34.6647 |     41.5281 |     31.4213 |
|       5. | 0.000100955 | 0.000341611 | 7.03377e-05 | 0.000720886 |

* From the files [assembly].qv
    1. assembly of interest. Both is combined of the above two.
    2. k-mers uniquely found only in the assembly
    3. k-mers found in both assembly and the read set
    4. QV
    5. Error rate
        * From the [documentation](https://github.com/marbl/merqury/wiki/2.-Overall-k-mer-evaluation)

| Assembly |  flye (p) |  flye (r) |  canu (p) |  canu (r) |
|----------|-----------|-----------|-----------|-----------|
|       2. |       all |       all |       all |       all |
|       3. | 107160335 | 106580283 | 106536590 | 105048523 |
|       4. | 108908489 | 108908489 | 108908489 | 108908489 |
|       5. |   98.3948 |   97.8622 |   97.8221 |   96.4558 |

* From the files [assembly].[completeness].stats
    1. Assembly
    2. k-mer set used for measuring completeness - all = read set (This gets expended with hap-mers later)
    3. solid k-mers in the assembly
    4. Total solid k-mers in the read set
    5. Completeness (%)
        * From the [documentation](https://github.com/marbl/merqury/wiki/2.-Overall-k-mer-evaluation)

### Assembly polishing
* How much does the polishing improve your assemblies (run the assembly evaluations on the polished and non-polished assemblies)?
    * *With the evaluation with BUSCO it does improve a little bit. The assembly with canu improves more than the assembly with flye*
    * *With the evaluation with QUAST the polishing does not improve the assemblies a lot.*
    * *With the evaluation with merqury the piolishing does improve the quality of the assemblies. Especially when looking at the QV and error rate.*

### Assembly evaluation
#### Assessing quality with BUSCO (Complete score above 95% is good)
* How do your genome assemblies look according to your BUSCO results? Is one genome assembly better than the other?
    * *They both look very similar and good*

* How does your transcriptome assembly look? Are there many duplicated genes? Can you explain the differences with the whole genome assemblies?
    * *The complete score is just 65% wich is very low. There are actually more duplicated ones than single-copy; and there are a lot of missing ones.*
    * *For transcriptomes or annotated gene sets this indicates that these orthologs are indeed missing or the transcripts or gene models are so incomplete/fragmented that they could not even meet the criteria to be considered as fragmented.* from [BUSCO](https://busco.ezlab.org/busco_userguide.html#interpreting-the-results)

#### Assessing quality with QUAST
* How do your genome assemblies look according to your QUAST results? Is one genome assembly better than the other?
    * *I would say the flye assembly is better, since NG50 is much higher (polished: 8822047, raw: 8819554) than the one from the canu assembly (polished: 433815, raw: 433505). This also counts for the NG75 (flye: polished: 1705972, raw: 1705414; canu: polished: 211025, raw: 209127).*
* What additional information you get if you have a reference available?
    * *We get information about missassemblies and unaligned contigs. Where the assemblies are either similar or again flye is much better.*

#### Assessing quality with merqury
* What are the consensus quality QV and error rate values of your assemblies?
    * *QV for flye (p: 39.96, r: 34.66)*
    * *QV for canu (p: 41.53, r: 31.42)*
    * *Error rate for flye (p:  0.0001, r: 0.0003)*
    * *Error rate for canu (p: 0.00007, r: 0.0007)*
* What is the estimated completeness of your assemblies?
    * *Completeness for flye (p: 98.34, r: 97.86)*
    * *Completeness for canu (p: 97.82, r: 96.46)*
* How does your copy-number spectra look like? Do they confirm the expected coverage?
    * *Yes they do look good.*
* Does one assembly perfom better than the other?
    * *Again flye does a bit better than canu.*