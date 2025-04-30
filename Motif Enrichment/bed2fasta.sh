#!/bin/bash
# source /opt/packages/anaconda3-2024.10-1/etc/profile.d/conda.sh

#SBATCH -p RM-shared
#SBATCH -t 2:00:00
#SBATCH --mem=6G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH -J bed2fasta_enhance
#SBATCH -e /jet/home/zhuang13/project/fasta_OCR/enhancer_run.err
#SBATCH -o /jet/home/zhuang13/project/fasta_OCR/enhancer_run.out
#SBATCH --export=ALL

module load bedtools
bash bed2fasta.sh
REF_DIR="/ocean/projects/bio230007p/zhuang13/ref/"
DATA_DIR="/jet/home/zhuang13/project/raw_OCR"
OUT_DIR="/jet/home/zhuang13/project/fasta_OCR"

bedtools getfasta -fi $REF_DIR/mm10.fa -bed $DATA_DIR/enhancer_Adrenals.bed -fo $OUT_DIR/enhancer_Adrenals.fa


