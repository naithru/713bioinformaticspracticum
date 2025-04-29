#!/bin/bash
module load bedtools

# Set working directory
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"

# Liver OCR input
LIVER_BED="$WORKDIR/mouse_liver_idr_clean.bed"

# Adrenal OCR input
ADRENAL_BED="$WORKDIR/mouse_Adrenal_idr_clean.bed"

# Mouse TSS file (sorted and cleaned)
TSS_BED="$WORKDIR/mouse_TSS_strand_clean_sorteddd.bed"

# --- Liver processing ---
LIVER_OUTDIR="$WORKDIR/Mouse_liver_annotated_OCRs"
mkdir -p $LIVER_OUTDIR
rm -f $LIVER_OUTDIR/*

# Find the closest TSS for Liver OCRs
bedtools closest -a $LIVER_BED -b $TSS_BED -D a > $LIVER_OUTDIR/mouse_liver_OCR_with_TSS_idr.bed

# Extract promoters (within ±2000 bp)
awk '($NF >= -2000 && $NF <= 2000)' $LIVER_OUTDIR/mouse_liver_OCR_with_TSS_idr.bed > $LIVER_OUTDIR/mouse_liver_idr_promoters.bed

# Extract enhancers (>2kb)
awk '($NF < -2000 || $NF > 2000)' $LIVER_OUTDIR/mouse_liver_OCR_with_TSS_idr.bed > $LIVER_OUTDIR/mouse_liver_idr_enhancers.bed

# Liver summary
echo "[Liver] Annotation complete."
echo "[Liver] Promoter count (within ±2kb): $(wc -l < $LIVER_OUTDIR/mouse_liver_idr_promoters.bed)"
echo "[Liver] Enhancer count (>2kb): $(wc -l < $LIVER_OUTDIR/mouse_liver_idr_enhancers.bed)"

# --- Adrenal processing ---
ADRENAL_OUTDIR="$WORKDIR/Mouse_adrenal_annotated_OCRs"
mkdir -p $ADRENAL_OUTDIR
rm -f $ADRENAL_OUTDIR/*

# Find the closest TSS for Adrenal OCRs
bedtools closest -a $ADRENAL_BED -b $TSS_BED -D a > $ADRENAL_OUTDIR/mouse_adrenal_OCR_with_TSS_idr.bed

# Extract promoters (within ±2000 bp)
awk '($NF >= -2000 && $NF <= 2000)' $ADRENAL_OUTDIR/mouse_adrenal_OCR_with_TSS_idr.bed > $ADRENAL_OUTDIR/mouse_adrenal_idr_promoters.bed

# Extract enhancers (>2kb)
awk '($NF < -2000 || $NF > 2000)' $ADRENAL_OUTDIR/mouse_adrenal_OCR_with_TSS_idr.bed > $ADRENAL_OUTDIR/mouse_adrenal_idr_enhancers.bed

# Adrenal summary
echo "[Adrenal] Annotation complete."
echo "[Adrenal] Promoter count (within ±2kb): $(wc -l < $ADRENAL_OUTDIR/mouse_adrenal_idr_promoters.bed)"
echo "[Adrenal] Enhancer count (>2kb): $(wc -l < $ADRENAL_OUTDIR/mouse_adrenal_idr_enhancers.bed)"

echo "Annotation complete for both Mouse_idr Liver and Adrenal OCRs."