#!/bin/bash
module load bedtools

# Path
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/cross-species/cross_species_liver_results"
TSS="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/mouse_TSS_strand_clean_sorteddd.bed"

# Input files
SHARED_OCR="$WORKDIR/shared_liver_OCR.bed"
HUMAN_SPECIFIC_OCR="$WORKDIR/human_specific_liver_OCR.bed"
MOUSE_SPECIFIC_OCR="$WORKDIR/mouse_specific_liver_OCR.bed"

echo "Start annotating promoter/enhancer for shared and specific liver OCRs..."

# Annotate Shared OCR in liver
bedtools closest -a $SHARED_OCR -b $TSS -D a > $WORKDIR/shared_liver_with_TSS.bed
awk '($NF >= -2000 && $NF <= 2000)' $WORKDIR/shared_liver_with_TSS.bed > $WORKDIR/shared_liver_promoters.bed
awk '($NF < -2000 || $NF > 2000)' $WORKDIR/shared_liver_with_TSS.bed > $WORKDIR/shared_liver_enhancers.bed

# Annotate Human-specific OCR
bedtools closest -a $HUMAN_SPECIFIC_OCR -b $TSS -D a > $WORKDIR/human_specific_liver_with_TSS.bed
awk '($NF >= -2000 && $NF <= 2000)' $WORKDIR/human_specific_liver_with_TSS.bed > $WORKDIR/human_specific_liver_promoters.bed
awk '($NF < -2000 || $NF > 2000)' $WORKDIR/human_specific_liver_with_TSS.bed > $WORKDIR/human_specific_liver_enhancers.bed

# Annotate Mouse-specific OCR
bedtools closest -a $MOUSE_SPECIFIC_OCR -b $TSS -D a > $WORKDIR/mouse_specific_liver_with_TSS.bed
awk '($NF >= -2000 && $NF <= 2000)' $WORKDIR/mouse_specific_liver_with_TSS.bed > $WORKDIR/mouse_specific_liver_promoters.bed
awk '($NF < -2000 || $NF > 2000)' $WORKDIR/mouse_specific_liver_with_TSS.bed > $WORKDIR/mouse_specific_liver_enhancers.bed

echo "Promoter/enhancer annotation completed."

# Summary counts of promoters and enhancers in liver shared and specific species(human and mouse)
echo "[Shared Liver OCRs]"
echo "  Promoters: $(wc -l < $WORKDIR/shared_liver_promoters.bed)"
echo "  Enhancers: $(wc -l < $WORKDIR/shared_liver_enhancers.bed)"

echo "[Human-specific Liver OCRs]"
echo "  Promoters: $(wc -l < $WORKDIR/human_specific_liver_promoters.bed)"
echo "  Enhancers: $(wc -l < $WORKDIR/human_specific_liver_enhancers.bed)"

echo "[Mouse-specific Liver OCRs]"
echo "  Promoters: $(wc -l < $WORKDIR/mouse_specific_liver_promoters.bed)"
echo "  Enhancers: $(wc -l < $WORKDIR/mouse_specific_liver_enhancers.bed)"
