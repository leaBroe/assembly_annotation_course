#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=maker
#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs/logs/phylo_analysis_TEs_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/phylogenetic_analysis_TEs/logs/phylo_analysis_TEs_%j.e
#SBATCH --partition=pall

course_dir=/data/users/lbroennimann/assembly_annotation_course
annotation_dir=${course_dir}/week_8_annotation

mkdir ${annotation_dir}

module load SequenceAnalysis/GenePrediction/maker/2.31.9;
maker -CTL

genome= <your genome assembly> #genome sequence (fasta file or fasta embeded in GFF3 file)

est= <assembled transcriptome> #set of ESTs or assembled mRNA-seq in fasta format
protein= /path/to/Atal_v10_CDS_proteins,/path/to/uniprotplant_reviewed.fasta #protein sequence file in fasta format (i.e. from mutiple organisms)
rmlib= $genome.mod.EDTA.TElib.fa #provide an organism specific repeat
library in fasta format for RepeatMasker
repeat_protein= PTREP20 #provide a fasta file of transposable element
proteins for RepeatRunner
st2genome=1 #infer gene predictions directly from ESTs, 1 = yes, 0 = no
protein2genome=1 #infer predictions from protein homology, 1 = yes, 0 = no
cpus=16 #max number of cpus to use in BLAST and RepeatMasker
TMP=$SCRATCH