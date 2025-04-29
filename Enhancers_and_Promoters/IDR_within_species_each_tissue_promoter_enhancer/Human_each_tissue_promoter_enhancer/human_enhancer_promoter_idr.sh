#!/bin/bash
module load bedtools
# This bash file: "human_enhancer_promoter_idr.sh" for human_liver_idr and human_adrenal_idr file to find promoters and enhancers

# Path
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"
TSS="$WORKDIR/human_TSS_strand_sorted.bed"

# --- Liver ---
LIVER_BED="$WORKDIR/human_liver_idr_clean3_sorted.bed"
LIVER_OUTDIR="$WORKDIR/region_by_TSS_idr_human_liver"
mkdir -p $LIVER_OUTDIR
rm -f $LIVER_OUTDIR/*

bedtools closest -a $LIVER_BED -b $TSS -D a > $LIVER_OUTDIR/liver_OCR_with_TSS_human_idr.bed
awk '($NF >= -2000 && $NF <= 2000)' $LIVER_OUTDIR/liver_OCR_with_TSS_human_idr.bed > $LIVER_OUTDIR/human_idr_liver_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $LIVER_OUTDIR/liver_OCR_with_TSS_human_idr.bed > $LIVER_OUTDIR/human_idr_liver_enhancers_2kbplus.bed

echo "[Liver] Promoter count (within-2kb): $(wc -l < $LIVER_OUTDIR/human_idr_liver_promoters_2kb.bed)"
echo "[Liver] Enhancer count (>2kb): $(wc -l < $LIVER_OUTDIR/human_idr_liver_enhancers_2kbplus.bed)"

# --- Adrenal ---
ADRENAL_BED="$WORKDIR/human_adrenal_idr_sorted.bed"
ADRENAL_OUTDIR="$WORKDIR/region_by_TSS_idr_human_adrenal"
mkdir -p $ADRENAL_OUTDIR
rm -f $ADRENAL_OUTDIR/*

bedtools closest -a $ADRENAL_BED -b $TSS -D a > $ADRENAL_OUTDIR/adrenal_OCR_with_TSS_human_idr.bed
awk '($NF >= -2000 && $NF <= 2000)' $ADRENAL_OUTDIR/adrenal_OCR_with_TSS_human_idr.bed > $ADRENAL_OUTDIR/human_idr_adrenal_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $ADRENAL_OUTDIR/adrenal_OCR_with_TSS_human_idr.bed > $ADRENAL_OUTDIR/human_idr_adrenal_enhancers_2kbplus.bed

echo "[Adrenal] Promoter count (within-2kb): $(wc -l < $ADRENAL_OUTDIR/human_idr_adrenal_promoters_2kb.bed)"
echo "[Adrenal] Enhancer count (>2kb): $(wc -l < $ADRENAL_OUTDIR/human_idr_adrenal_enhancers_2kbplus.bed)"

echo "Annotation complete for both Liver and Adrenal in Human_idr."