#!/bin/bash
module load bedtools

# Path
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"
TSS="$WORKDIR/mouse_TSS_strand_clean_sorteddd.bed"   # Mouse genome TSS annotation

# OCRs
HUMAN_MAPPED="$WORKDIR/cross-species/cross_species_liver_halper.bed"
MOUSE_OCR="$WORKDIR/mouse_liver_idr_clean.bed"

# Output directories
OUTDIR="$WORKDIR/cross-species/cross_species_liver_results"
mkdir -p $OUTDIR
rm -f $OUTDIR/*

echo "Start cross-species shared/specific analysis..."

# Find shared / specific OCRs in liver

# Find shared
bedtools intersect -a $HUMAN_MAPPED -b $MOUSE_OCR -u > $OUTDIR/shared_liver_OCR.bed

# Find human-specific
bedtools intersect -a $HUMAN_MAPPED -b $MOUSE_OCR -v > $OUTDIR/human_specific_liver_OCR.bed

# Find mouse-specific
bedtools intersect -a $MOUSE_OCR -b $HUMAN_MAPPED -v > $OUTDIR/mouse_specific_liver_OCR.bed

echo "Shared / specific OCRs in liver found."

