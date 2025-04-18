#!/bin/bash
module load bedtools
# Define input files
liver="Liver_mouse_peaks.bed"
adrenal="Adrenal_mouse_peaks.bed"

# Define output folder
output_dir="step3a_mouse"
mkdir -p $output_dir

# Shared OCRs
bedtools intersect -a $liver -b $adrenal -u > $output_dir/mouse_shared_OCRs.bed

# Liver-only OCRs
bedtools intersect -a $liver -b $adrenal -v > $output_dir/mouse_liver_only_OCRs.bed

# Adrenal-only OCRs
bedtools intersect -a $adrenal -b $liver -v > $output_dir/mouse_adrenal_only_OCRs.bed

# Count results
echo "Mouse OCR Comparison:"
echo "Shared: $(wc -l < $output_dir/mouse_shared_OCRs.bed)"
echo "Liver only: $(wc -l < $output_dir/mouse_liver_only_OCRs.bed)"
echo "Adrenal only: $(wc -l < $output_dir/mouse_adrenal_only_OCRs.bed)"
