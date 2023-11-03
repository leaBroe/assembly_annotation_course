#!/usr/bin/env bash

#SBATCH --mail-user=lea.broennimann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall

#SBATCH --time=2-20:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16

#SBATCH --job-name=maker
#SBATCH --output=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/7_maker_%j.o
#SBATCH --error=/data/users/lbroennimann/assembly_annotation_course/MAKER/logs/7_maker_%j.e

# Load the module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

# Define output and input directories
course_dir=/data/users/lbroennimann/assembly_annotation_course
output_dir=${course_dir}/MAKER
    mkdir ${output_dir}
    cd ${output_dir}
ctl=${course_dir}/scripts/07_01_perform_annotation_with_MAKER_opts.ctl

COURSEDIR=/data/courses/assembly-annotation-course
SOFTWAREDIR=/software

ln -s ${COURSEDIR}/CDS_annotation


# 1) CREATE CONTROL FILES (templates)
singularity exec \
--bind ${SCRATCH} \
--bind ${COURSEDIR} \
--bind ${SOFTWAREDIR} \
--bind ${course_dir} \
${COURSEDIR}/containers2/MAKER_3.01.03.sif \
maker -CTL


# 2) COPY THE PREPARED MAKER OPTIONS from script folder to output folder (overwriting the freshly created template)
cp ${ctl} ${output_dir}/maker_opts.ctl


# 3) RUN MAKER
mpiexec -n 16 singularity exec \
--bind ${SCRATCH} \
--bind ${COURSEDIR} \
--bind ${SOFTWAREDIR} \
--bind ${course_dir} \
${COURSEDIR}/containers2/MAKER_3.01.03.sif \
maker -mpi -base run_mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl