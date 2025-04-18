#!/bin/bash
module load bedtools
# Define input files
liver="Liver_human_peaks.bed"
adrenal="Adrenal_human_peaks.bed"

# Define output folder
output_dir="step3a_human"
mkdir -p $output_dir

# Shared OCRs
bedtools intersect -a $liver -b $adrenal -u > $output_dir/human_shared_OCRs.bed

# Liver-only OCRs
bedtools intersect -a $liver -b $adrenal -v > $output_dir/human_liver_only_OCRs.bed

# Adrenal-only OCRs
bedtools intersect -a $adrenal -b $liver -v > $output_dir/human_adrenal_only_OCRs.bed

# Count results
echo "Human OCR Comparison:"
echo "Shared: $(wc -l < $output_dir/human_shared_OCRs.bed)"
echo "Liver only: $(wc -l < $output_dir/human_liver_only_OCRs.bed)"
echo "Adrenal only: $(wc -l < $output_dir/human_adrenal_only_OCRs.bed)"

