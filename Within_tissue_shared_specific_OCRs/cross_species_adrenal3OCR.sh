#!/bin/bash
module load bedtools

# Path
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"
HUMAN_MAPPED="$WORKDIR/cross-species/cross_species_adrenal_halper.bed"
MOUSE_OCR="$WORKDIR/mouse_Adrenal_idr_clean.bed"

OUTDIR="$WORKDIR/cross-species/cross_species_adrenal_results"
mkdir -p $OUTDIR
rm -f $OUTDIR/*

echo "Start cross-species shared/specific analysis for Adrenal..."

# Find shared and specific OCRs

# Find cross-species shared OCR
bedtools intersect -a $HUMAN_MAPPED -b $MOUSE_OCR -u > $OUTDIR/shared_adrenal_OCR.bed

# Find human-specific OCR
bedtools intersect -a $HUMAN_MAPPED -b $MOUSE_OCR -v > $OUTDIR/human_specific_adrenal_OCR.bed

# Find mouse-specific OCR
bedtools intersect -a $MOUSE_OCR -b $HUMAN_MAPPED -v > $OUTDIR/mouse_specific_adrenal_OCR.bed

echo "Shared and specific adrenal OCRs identified."
