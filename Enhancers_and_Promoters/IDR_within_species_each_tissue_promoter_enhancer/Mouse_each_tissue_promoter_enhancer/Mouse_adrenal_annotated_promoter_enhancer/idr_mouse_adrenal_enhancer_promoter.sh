#!/bin/bash
module load bedtools

# Set working directory
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"

# Input files
ADRENAL_BED="$WORKDIR/mouse_adrenal_idr_clean.bed"   # 只保留chr/start/end并且已经排序的Adrenal OCR
TSS_BED="$WORKDIR/mouse_TSS_strand_clean_sorteddd.bed"  # 小鼠TSS，已排序

# Output directory
ADRENAL_OUTDIR="$WORKDIR/Mouse_adrenal_annotated_OCRs"
mkdir -p $ADRENAL_OUTDIR
rm -f $ADRENAL_OUTDIR/*

# Step 1: Find the closest TSS for each Adrenal OCR
bedtools closest -a $ADRENAL_BED -b $TSS_BED -D a > $ADRENAL_OUTDIR/mouse_adrenal_OCR_with_TSS_idr.bed

# Step 2: Extract promoters (within ±2000 bp)
awk '($NF >= -2000 && $NF <= 2000)' $ADRENAL_OUTDIR/mouse_adrenal_OCR_with_TSS_idr.bed > $ADRENAL_OUTDIR/mouse_adrenal_idr_promoters.bed

# Step 3: Extract enhancers (>2kb)
awk '($NF < -2000 || $NF > 2000)' $ADRENAL_OUTDIR/mouse_adrenal_OCR_with_TSS_idr.bed > $ADRENAL_OUTDIR/mouse_adrenal_idr_enhancers.bed

# Step 4: Summary
echo "[Adrenal] Annotation complete."
echo "[Adrenal] Promoter count (within ±2kb): $(wc -l < $ADRENAL_OUTDIR/mouse_adrenal_idr_promoters.bed)"
echo "[Adrenal] Enhancer count (>2kb): $(wc -l < $ADRENAL_OUTDIR/mouse_adrenal_idr_enhancers.bed)"
