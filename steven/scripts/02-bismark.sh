#!/bin/bash
## Job Name
#SBATCH --job-name=re-d4
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes 
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=8-00:00:00
## Memory per node
#SBATCH --mem=100G
#SBATCH --mail-type=ALL

#SBATCH --mail-user=sr320@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/sr320/1231/



# Directories and programs
bismark_dir="/gscratch/srlab/programs/Bismark-0.21.0"
bowtie2_dir="/gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64/"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
reads_dir="/gscratch/srlab/strigg/data/Pgenr/FASTQS/"
genome_folder="/gscratch/srlab/sr320/data/geoduck/v01/"

source /gscratch/srlab/programs/scripts/paths.sh

# What will this do to the repo, since I haven't pulled from main repo?
#
#${bismark_dir}/bismark_genome_preparation \
#--verbose \
#--parallel 28 \
#--path_to_aligner ${bowtie2_dir} \

#SBATCH --ma

#${genome_folder}


find ${reads_dir}*_R1_001_val_1.fq.gz \
| xargs basename -s _R1_00
#--verbose \
#--parallel 28 \adfajdfjajkfkajf
akfakfjkasjf
akfakdjfkajdf
akakdfjakf



--merge_CpG \
--zero_based \
{}_R1_001_val_1_bismark_bt2_pe.deduplicated.bismark.cov.gz


#creating bedgraphs post merge

for f in *merged_CpG_evidence.cov
do
  STEM=$(basename "${f}" .CpG_report.merged_CpG_evidence.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 10) {print $1, $2, $3, $4}}' \
  > "${STEM}"_10x.bedgraph
done



for f in *merged_CpG_evidence.cov
do
  STEM=$(basename "${f}" .CpG_report.merged_CpG_evidence.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 5) {print $1, $2, $3, $4}}' \
  > "${STEM}"_5x.bedgraph
done


#creating tab files with raw count for glms

for f in *merged_CpG_evidence.cov
do
  STEM=$(basename "${f}" .CpG_report.merged_CpG_evidence.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 10) {print $1, $2, $3, $4, $5, $6}}' \
  > "${STEM}"_10x.tab
done


for f in *merged_CpG_evidence.cov
do
  STEM=$(basename "${f}" .CpG_report.merged_CpG_evidence.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 5) {print $1, $2, $3, $4, $5, $6}}' \
  > "${STEM}"_5x.tab
done
