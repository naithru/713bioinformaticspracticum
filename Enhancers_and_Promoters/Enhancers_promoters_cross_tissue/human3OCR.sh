#!/bin/bash
module load bedtools
# Code for human_OCR: liver_only, adrenal_only and shared bed files to find promoters and enhancers

# Path
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"
TSS="$WORKDIR/human_TSS_strand_sorted.bed"

# === Shared OCRs ===
SHARED_BED="/ocean/projects/bio230007p/jzhao15/project/step3a/step3a_human/human_shared_OCR_clean.bed"
SHARED_OUTDIR="$WORKDIR/region_by_TSS_distance_shared"
mkdir -p $SHARED_OUTDIR
bedtools closest -a $SHARED_BED -b $TSS -D a > $SHARED_OUTDIR/shared_OCR_with_TSS_distance.bed
awk '($NF >= -2000 && $NF <= 2000)' $SHARED_OUTDIR/shared_OCR_with_TSS_distance.bed > $SHARED_OUTDIR/shared_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $SHARED_OUTDIR/shared_OCR_with_TSS_distance.bed > $SHARED_OUTDIR/shared_enhancers_2kbplus.bed
echo "[Shared] Promoter count (±2kb): $(wc -l < $SHARED_OUTDIR/shared_promoters_2kb.bed)"
echo "[Shared] Enhancer count (>2kb): $(wc -l < $SHARED_OUTDIR/shared_enhancers_2kbplus.bed)"

# === Liver-only OCRs ===
LIVER_BED="/ocean/projects/bio230007p/jzhao15/project/step3a/step3a_human/human_liver_OCR_clean.bed"
LIVER_OUTDIR="$WORKDIR/region_by_TSS_distance_liver"
mkdir -p $LIVER_OUTDIR
bedtools closest -a $LIVER_BED -b $TSS -D a > $LIVER_OUTDIR/liver_OCR_with_TSS_distance.bed
awk '($NF >= -2000 && $NF <= 2000)' $LIVER_OUTDIR/liver_OCR_with_TSS_distance.bed > $LIVER_OUTDIR/liver_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $LIVER_OUTDIR/liver_OCR_with_TSS_distance.bed > $LIVER_OUTDIR/liver_enhancers_2kbplus.bed
echo "[Liver] Promoter count (±2kb): $(wc -l < $LIVER_OUTDIR/liver_promoters_2kb.bed)"
echo "[Liver] Enhancer count (>2kb): $(wc -l < $LIVER_OUTDIR/liver_enhancers_2kbplus.bed)"

# === Adrenal-only OCRs ===
ADRENAL_BED="/ocean/projects/bio230007p/jzhao15/project/step3a/step3a_human/human_adrenal_OCR_clean.bed"
ADRENAL_OUTDIR="$WORKDIR/region_by_TSS_distance_adrenal"
mkdir -p $ADRENAL_OUTDIR
bedtools closest -a $ADRENAL_BED -b $TSS -D a > $ADRENAL_OUTDIR/adrenal_OCR_with_TSS_distance.bed
awk '($NF >= -2000 && $NF <= 2000)' $ADRENAL_OUTDIR/adrenal_OCR_with_TSS_distance.bed > $ADRENAL_OUTDIR/adrenal_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $ADRENAL_OUTDIR/adrenal_OCR_with_TSS_distance.bed > $ADRENAL_OUTDIR/adrenal_enhancers_2kbplus.bed
echo "[Adrenal] Promoter count (±2kb): $(wc -l < $ADRENAL_OUTDIR/adrenal_promoters_2kb.bed)"
echo "[Adrenal] Enhancer count (>2kb): $(wc -l < $ADRENAL_OUTDIR/adrenal_enhancers_2kbplus.bed)"

echo "Annotation complete for Shared, Liver-only, and Adrenal-only OCRs."